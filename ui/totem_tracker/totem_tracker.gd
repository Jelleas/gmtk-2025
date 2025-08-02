extends PanelContainer

class_name TotemTracker

@export var totem_manager: TotemInterface

var totem: Totem

func _ready() -> void:
	totem_manager.TotemSelected.connect(_on_totem_selected)
	hide()
	
func _on_totem_selected(totem_: Totem):
	totem = totem_

	$HBoxContainer/DescriptionLabel.text = totem.name
	
	var produces_map = _create_resource_map(totem.produces)
	$HBoxContainer/ProducesResourceList.set_resources(produces_map)
	
	var consumes_map = _create_resource_map(totem.consumes)
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
