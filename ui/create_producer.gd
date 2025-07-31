extends Button

var tower_scene: PackedScene
var resource_manager: Path2D

var start: int
var end: int

func init(res_man: Path2D, tower: PackedScene, position_x: int, position_y: int):
	resource_manager = res_man
	tower_scene = tower
	start = position_x
	end = position_y

func _pressed() -> void:
	var tower = tower_scene.instantiate()
	add_child(tower)
	
	# init resource script
	tower.init(resource_manager, Res.Type.WOOD, start, end)
