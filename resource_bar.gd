extends TextureProgressBar

@export var resource_path: Path2D

func _ready() -> void:
	max_value = resource_path.SIZE

func _process(delta: float) -> void:
	var count = 0
	for c in resource_path.contents:
		if c != null:
			count += 1
	
	value = count
