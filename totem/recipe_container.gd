extends PanelContainer

var totem: Totem
	
func _ready() -> void:
	$HBoxContainer/ArrowRect.hide()
	hide()
	
func init(totem_: Totem) -> void:
	totem = totem_
	totem.TotemChanged.connect(_on_totem_changed)
	show()

func _on_totem_changed(totem_: Totem):
	totem = totem_
	show()
	
	if totem.get_consumes().size() > 0 and totem.get_produces().size() > 0:
		$HBoxContainer/ArrowRect.show()
	else:
		$HBoxContainer/ArrowRect.hide()
	
	set_consumes()
	set_produces()
	
func set_consumes():
	var container = $HBoxContainer/ConsumesContainer
	
	for child in container.get_children():
		child.free()
	
	set_resources_in_container(
		totem.get_consumes(),
		container
	)

func set_produces():
	var container = $HBoxContainer/ProducesContainer
		
	for child in container.get_children():
		child.free()
	
	set_resources_in_container(
		totem.get_produces(),
		container
	)
		
func set_resources_in_container(resources: Array[Res.Type], container: Container) -> void:
	for r in resources:
		var rect = TextureRect.new()
		var image_path = Res.image_path(r)
		rect.texture = get_image(load(image_path))
		container.add_child(rect)

func get_image(resource: Resource) -> ImageTexture:
	var image = resource.get_image()
	image.resize(32, 32, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)
