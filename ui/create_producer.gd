extends Button

@export var tower_scene: PackedScene
@export var resource_manager: Path2D

	
func _pressed() -> void:
	var tower = tower_scene.instantiate()
	add_child(tower)
	
	# init resource script
	tower.init(resource_manager, Res.Type.WOOD, 0, 0)
