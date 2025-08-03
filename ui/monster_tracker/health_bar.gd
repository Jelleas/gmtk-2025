extends TextureProgressBar

var max_health: int = 100

var monster_path: Path2D
var initialized = false

func _ready() -> void:
	add_to_group("monster_trackers")

func init(monster_path_: Path2D) -> void:
	monster_path = monster_path_
	initialized = true
	monster_path.monster_escape.connect(_on_monster_escape)

func _on_monster_escape(monster: Monster):
	value -= monster.config.escape_cost
	
	if(value < 1):
		get_tree().change_scene_to_file("res://ui/menu_screens/game_over.tscn")
