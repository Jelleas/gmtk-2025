extends Button

var totem_scene: PackedScene
var resource_manager: Path2D

var start: int
var end: int
var resource: Res.Type

var is_created = false
var totem

func init(res_man: Path2D, totem: PackedScene, resource_type: Res.Type, position_x: int, position_y: int):
	resource_manager = res_man
	totem_scene = totem
	start = position_x
	end = position_y
	resource = resource_type

func _pressed() -> void:
	if (!is_created):
		create_totem()
	else:
		totem.upgrade_speed()

func create_totem():
	is_created = true
	totem = totem_scene.instantiate()
	add_child(totem)
	
	totem.init(resource_manager, resource, start, end)
