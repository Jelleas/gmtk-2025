extends Label

var escaped_monsters_count = 0

var monster_path: Path2D
var initialized = false

func _ready() -> void:
	add_to_group("monster_trackers")

func init(monster_path_: Path2D) -> void:
	monster_path = monster_path_
	initialized = true
	monster_path.monster_escape.connect(_on_monster_escape)

func _on_monster_escape(monster: Monster):
	escaped_monsters_count += 1
	if escaped_monsters_count == 1:
		text = str(escaped_monsters_count) + " monster loop"
	else:
		text = str(escaped_monsters_count) + " monster loops"
	
