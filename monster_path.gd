extends Path2D

@export var monster_scene: PackedScene
@export var loop_seconds: float = 10

func _ready() -> void:
	var monster = monster_scene.instantiate()
	add_child(monster)

func _process(delta: float) -> void:
	pass
