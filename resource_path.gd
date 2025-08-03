extends Path2D

class_name ResourceManager

@export var resource_scene: PackedScene
@export var loop_seconds: float = 10
var SIZE: int = 72
var contents: Array[Res] = []
var index_modifier: float = 0 # position of the path

func _ready():
	for i in range(SIZE):
		contents.append(null)

func _process(delta: float) -> void:
	index_modifier += fmod(delta * (1 / loop_seconds), 1)
	
	for i in range(SIZE):
		if contents[i] != null:
			contents[i].progress_ratio = get_resource_progress_ratio(i)

func deposit(resource: Res.Type, start: int, end: int, source_global_pos: Vector2) -> bool:
	for i in range(start, end + 1):
		if create_resource(resource, i, source_global_pos):
			return true
	return false
	
func consume(resource: Res.Type, start: int, end: int) -> Res:
	for i in range(start, end + 1):
		return get_resource(resource, i)
	return null

func get_resource(resource: Res.Type, index: int) -> Res:
	var actual_index = translate_index(index)
	var res = contents[actual_index]
	if res != null && res.type == resource:
		contents[actual_index] = null
		return res
	return null
	
func create_resource(resource_enum: Res.Type, index: int, source_global_pos: Vector2) -> bool:
	var actual_index = translate_index(index)
	
	if contents[actual_index] != null:
		return false

	var resource: Res = resource_scene.instantiate()
	add_child(resource)
	
	# init resource script
	resource.init(resource_enum, get_resource_progress_ratio(actual_index))
	var destination_pos: Vector2 = resource.global_position
	resource.global_position = source_global_pos
	create_tween().tween_property(resource, "global_position", destination_pos, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	# add to inventory
	contents[actual_index] = resource
	
	return true

func get_resource_progress_ratio(translated: int) -> float:
	var real_index = inverse_translate_index(translated)
	var offset = fmod(index_modifier, float(1) / SIZE)
	
	var ratio = float(real_index) / SIZE
	return ratio - offset

func translate_index(index: int) -> int:
	return int(index + floor(index_modifier * SIZE)) % SIZE
	
func inverse_translate_index(translated: int) -> int:
	var offset = floor(index_modifier * SIZE)
	return fmod((translated - offset + SIZE), SIZE)
