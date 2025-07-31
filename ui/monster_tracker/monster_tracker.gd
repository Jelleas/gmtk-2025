extends VBoxContainer

@export var monster_path: Path2D;

func _ready() -> void:
	get_tree().call_group("monster_trackers", "init", monster_path)
