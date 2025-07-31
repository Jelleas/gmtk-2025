extends Path2D

signal monster_escape(monster: Monster)

@export var monster_scene: PackedScene
@export var loop_seconds: float = 10

var monsters: Array[Monster]

func _ready() -> void:
	spawn(Monster.Type.BLOB)
	
func _process(delta: float) -> void:
	pass

func spawn(type: Monster.Type):
	var monster = monster_scene.instantiate()
	monster.init(type)
	add_child(monster)
	
	monsters.append(monster)
	
	monster.monster_escape.connect(_on_monster_escape)
	
func _on_monster_escape(monster: Monster):
	monster_escape.emit(monster)

func _on_child_exiting_tree(node: Node) -> void:
	monsters.erase(node)
