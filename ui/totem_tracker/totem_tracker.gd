extends PanelContainer

class_name TotemTracker

@export var totem_manager: TotemInterface

var totem: Totem

var old_energy: int

func _ready() -> void:
	totem_manager.TotemSelected.connect(_on_totem_selected)
	hide()
	
func _process(delta: float) -> void:
	if totem == null or totem.base == null:
		return

	var energy_bar = $HBoxContainer/MarginContainer/EnergyBar

	var current_energy = totem.get_current_energy()
	energy_bar.value = current_energy
	var total_energy = totem.get_total_energy()
	energy_bar.max_value = total_energy
	
	var tween = create_tween()
	tween.tween_property(
		energy_bar,
		"value", 
		current_energy,
		0.1
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	old_energy = current_energy
	
func _on_totem_changed(totem_: Totem):
	set_totem()
	
func _on_totem_selected(totem_: Totem):
	if totem != null:
		totem.TotemChanged.disconnect(_on_totem_changed)
	
	totem = totem_
	set_totem()
	
	totem.TotemChanged.connect(_on_totem_changed)
	
func set_totem():
	set_header()
	
	$HBoxContainer/DescriptionLabel.text = totem.name()

	set_consumes()
	set_produces()
	set_shoots()
	
	$HBoxContainer/MarginContainer3/StatsGrid.set_stats(totem)

	show()

func set_header():
	var rect = $HBoxContainer/MarginContainer2/TextureRect
	if totem.base == null:
		rect.hide()
	else:
		var texture = totem.base.icon
		var image = texture.get_image()
		image.resize(68, 48, Image.INTERPOLATE_LANCZOS)

		var resized_texture = ImageTexture.create_from_image(image)
		rect.texture = resized_texture

		rect.show()

func set_consumes():
	var list = $HBoxContainer/ConsumesResourceList
	var label = $HBoxContainer/ConsumesLabel
	
	if totem.get_consumes().size() == 0:
		list.hide()
		label.hide()
	else:
		var consumes_map = _create_resource_map(totem.get_consumes())
		list.show()
		list.set_resources(consumes_map)
		label.show()
	
func set_produces():
	if totem.get_produces().size() == 0:
		$HBoxContainer/ProducesResourceList.hide()
		$HBoxContainer/ProducesLabel.hide()
	else:
		var produces_map = _create_resource_map(totem.get_produces())
		$HBoxContainer/ProducesResourceList.show()
		$HBoxContainer/ProducesResourceList.set_resources(produces_map)
		$HBoxContainer/ProducesLabel.show()
	
func set_shoots():
	if totem.get_shoots_image_path() == null:
		$HBoxContainer/ShootsContainer.hide()
		$HBoxContainer/ShootsLabel.hide()
	else:
		var rect = TextureRect.new()
		rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		rect.stretch_mode = TextureRect.STRETCH_KEEP
		var path = totem.get_shoots_image_path()
		var image = load(path).get_image()
		image.resize(32, 32, Image.INTERPOLATE_LANCZOS)
		var resized_texture = ImageTexture.create_from_image(image)
		
		rect.texture = resized_texture
		$HBoxContainer/ShootsContainer.add_child(rect)		
		$HBoxContainer/ShootsContainer.show()
		$HBoxContainer/ShootsLabel.show()
	
func _create_resource_map(resources: Array[Res.Type]) -> Dictionary[Res.Type, int]:
	var resource_map: Dictionary[Res.Type, int] = {}
	for res in resources:
		if res not in resource_map:
			resource_map[res] = 1
		else:
			resource_map[res] += 1
	return resource_map
