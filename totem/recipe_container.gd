extends PanelContainer

var totem: Totem
	
func _ready() -> void:
	$HBoxContainer/ArrowRect.hide()
	$HBoxContainer/ArrowRect.texture = get_image(load("res://assets/resources/arrow.png"))
	hide()
	
func init(totem_: Totem) -> void:
	totem = totem_
	totem.TotemChanged.connect(_on_totem_changed)
	show()
	set_conversion_arrow()
	set_consumes()
	set_produces()

func _on_totem_changed(totem_: Totem) -> void:
	totem = totem_
	show()
	
	set_conversion_arrow()
	set_consumes()
	set_produces()
	
func set_conversion_arrow() -> void:
	var is_consuming = totem.get_consumes().size() > 0
	var is_producing = totem.get_produces().size() > 0 or totem.get_shoots_image_path() != null
	
	if is_consuming and is_producing:
		$HBoxContainer/ArrowRect.show()
	else:
		$HBoxContainer/ArrowRect.hide()

func set_consumes() -> void:
	var container = $HBoxContainer/ConsumesContainer/MarginContainer/HBoxContainer
	
	for child in container.get_children():
		child.free()
	
	var consumes = totem.get_consumes()
	
	if consumes.size() == 0:
		$HBoxContainer/ConsumesContainer.hide()
	else:
		set_resources_in_container(
			consumes,
			container
		)
		$HBoxContainer/ConsumesContainer.show()
	
func set_produces() -> void:
	var container = $HBoxContainer/ProducesContainer/MarginContainer/HBoxContainer
		
	for child in container.get_children():
		child.free()
	
	var produces = totem.get_produces()
	print(produces)
	if produces.size() == 0 and totem.get_shoots_image_path() == null:
		$HBoxContainer/ProducesContainer.hide()
	else:
		set_resources_in_container(
			produces,
			container
		)
		$HBoxContainer/ProducesContainer.show()
		
		# add shooting items to produces
		if totem.get_shoots_image_path() != null:
			var rect = TextureRect.new()
			var shoots_image_path = totem.get_shoots_image_path()
			rect.texture = get_image(load(shoots_image_path))
			container.add_child(rect)
		
func set_resources_in_container(resources: Array[Res.Type], container: Container) -> void:
	for r in resources:
		var rect = TextureRect.new()
		var image_path = Res.image_path(r)
		rect.texture = get_image(load(image_path))
		container.add_child(rect)

func get_image(resource: Resource) -> ImageTexture:
	var image = resource.get_image()
	image.resize(48, 48, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)
