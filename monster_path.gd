extends Path2D

@export var monster_scene: PackedScene
@export var loop_seconds: float = 10

func _ready() -> void:
	spawn(Monster.Type.BLOB)
	
func _process(delta: float) -> void:
	pass

func spawn(type: Monster.Type):
	var monster = monster_scene.instantiate()
	monster.init(type)
	add_child(monster)
	
	monster.monster_escape.connect(_on_monster_escape)
	
func _on_monster_escape(cost: int):
	print(cost)
