extends TextureProgressBar

var resource_path: Path2D
var initialized = false

func init(resource_path_: Path2D) -> void:
	resource_path = resource_path_
	max_value = resource_path.SIZE
	initialized = true

func _process(delta: float) -> void:
	if !initialized:
		return
	
	var count = 0
	for c in resource_path.contents:
		if c != null:
			count += 1
	
	value = count
