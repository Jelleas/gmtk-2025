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
			contents[i].progress_ratio = get_resource_progress_ratio(i)

func deposit(content, start: int, end: int) -> bool: # type hint?
	for i in range(start, end + 1):
		if create_resource(content, i):
			return true
	return false
	
func consume(content, start: int, end: int) -> bool:
	for i in range(start, end - 1):
		if get_resource(content, i):
			return true
	return false

func get_resource(content, index: int) -> bool:
	var actual_index = translate_index(index)
	return false
	
func create_resource(content, index: int) -> bool:
	var actual_index = translate_index(index)
	
	if contents[actual_index] != null:
		return false
	
	var resource_scene = load("res://resource.tscn")
	var resource = resource_scene.instantiate()
	add_child(resource)
	
	# init resource script
	resource.init(content, get_resource_progress_ratio(index), loop_seconds)
	
	# add to inventory
	contents[actual_index] = resource
	
	return true

func get_resource_progress_ratio(index: int) -> float:
	var offset = fmod(index_modifier, float(1) / SIZE)
	return float(index) / SIZE + offset

func translate_index(index: int) -> int:
	return int(index + floor(index_modifier * SIZE)) % SIZE
