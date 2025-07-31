extends Label

var resource_path: Path2D
var initialized = false

func _ready() -> void:
	add_to_group("resource_trackers")

func init(resource_path_: Path2D) -> void:
	resource_path = resource_path_
	initialized = true

func _process(delta: float) -> void:
	if !initialized:
		return
	
	var count = 0
	for c in resource_path.contents:
		if c != null and c.type == Res.Type.FROG:
			count += 1
	
	text = str(count)
