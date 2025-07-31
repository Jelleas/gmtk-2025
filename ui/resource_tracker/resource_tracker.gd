extends CanvasLayer

@export var resource_path: Path2D;

func _ready() -> void:
	get_tree().call_group("resource_trackers", "init", resource_path)
