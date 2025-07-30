extends Path2D

@export var loop_seconds: float = 10
var SIZE: int = 72
var contents: Array = [] # type hint?
var index_modifier: float = 0 # position of the path

func _ready():
	for i in range(SIZE):
		contents.append(null)

func _process(delta: float) -> void:
	index_modifier += fmod(delta * (1 / loop_seconds), 1)
	
	for i in range(SIZE):
		if contents[i] != null:
			var offset = fmod(index_modifier, float(1) / SIZE)
			var progress_ratio_: float = float(i) / SIZE + offset
			contents[i].progress_ratio = progress_ratio_

func translate_index(index: int) -> int:
	return int(index + floor(index_modifier * SIZE)) % SIZE
	
func deposit(content, start: int, end: int) -> bool: # type hint?
	for i in range(start, end + 1):
		if create_resource(content, i):
			return true
	return false

func create_resource(content, index: int) -> bool:
	var actual_index = translate_index(index)
	
	if contents[actual_index] != null:
		return false
	
	var resource_scene = load("res://resource.tscn")
	var resource = resource_scene.instantiate()
	add_child(resource)
	
	# init resource script
	var offset = fmod(index_modifier, 1 / SIZE)
	resource.init(content, float(index) / SIZE + offset, loop_seconds)
	
	# add to inventory
	contents[actual_index] = resource
	
	return true
