extends Button

var totem_scene: PackedScene
var resource_manager: Path2D
var start: int
var end: int
var is_created: bool = false
var totem

func init(res_man: Path2D, totem: PackedScene, position_x: int, position_y: int):
	resource_manager = res_man
	totem_scene = totem
	start = position_x
	end = position_y


func _pressed() -> void:
	if (!is_created):
		create_totem()
	else:
		totem.add_two_to_one()

func create_totem() -> void:
	totem = totem_scene.instantiate()
	add_child(totem)
	
	# init resource script
	totem.init(resource_manager, -1, start, end)
	is_created = true
