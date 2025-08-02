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
	$HBoxContainer/DescriptionLabel.text = totem.name()
	
	var produces_map = _create_resource_map(totem.get_produces())
	$HBoxContainer/ProducesResourceList.set_resources(produces_map)
	
	var consumes_map = _create_resource_map(totem.get_consumes())
	$HBoxContainer/ConsumesResourceList.set_resources(consumes_map)

	show()
	
func _create_resource_map(resources: Array[Res.Type]) -> Dictionary[Res.Type, int]:
	var resource_map: Dictionary[Res.Type, int] = {}
	for res in resources:
		if res not in resource_map:
			resource_map[res] = 1
		else:
			resource_map[res] += 1
	return resource_map
