extends Path2D

@export var loop_seconds: float = 10
var SIZE: int = 72
var contents: Array[Node] = []
var index_modifier: float = 0 # position of the path

func _ready():
	for i in range(SIZE):
		contents.append(null)

func _process(delta: float) -> void:
	index_modifier += fmod(delta * (1 / loop_seconds), 1)
	
	for i in range(SIZE):
		if contents[i] != null:
			contents[i].progress_ratio = get_resource_progress_ratio(i)

func deposit(resource: Res.Type, start: int, end: int) -> bool:
	for i in range(start, end + 1):
		if create_resource(resource, i):
			return true
	return false
	
func consume(resource: Res.Type, start: int, end: int) -> bool:
	for i in range(start, end + 1):
		if get_resource(resource, i):
			return true
	return false

func get_resource(resource: Res.Type, index: int) -> bool:
	var actual_index = translate_index(index)
	if  contents[actual_index] != null && contents[actual_index].type == resource:
		remove_child(contents[actual_index])
		contents[actual_index] = null
		return true
	return false
	
func create_resource(resource_enum: Res.Type, index: int) -> bool:
	var actual_index = translate_index(index)
	
	if contents[actual_index] != null:
		return false
	
	var resource_scene = load("res://resource.tscn")
	var resource = resource_scene.instantiate()
	add_child(resource)
	
	# init resource script
	resource.init(resource_enum, get_resource_progress_ratio(actual_index))
	
	# add to inventory
	contents[actual_index] = resource
	
	return true

func get_resource_progress_ratio(index: int) -> float:
	var real_index = (index_modifier * SIZE) - index
	if (real_index < 0):
		real_index += SIZE
	
	var ratio = float(real_index) / SIZE
	return ratio

func translate_index(index: int) -> int:
	return int(index + floor(index_modifier * SIZE)) % SIZE
