extends Node2D

class_name Totem

@export var start: int
@export var end: int
@export var resource_manager: Path2D
@export var internal_timer: float = 10.0

var actions: Array = []
var needed_resources:Array = []
var created_resources:Array = []
var modifiers: Array = []

var base:TotemPieces.BaseType = TotemPieces.BaseType.EMPTY

func init(resource_man: Path2D, resource: Res.Type, start_index: int, end_index: int):
	resource_manager = resource_man
	start = start_index
	end = end_index
	if(resource != -1):
		base = TotemPieces.BaseType.PRODUCER
		actions.append(func() -> void: create(resource))

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)
	produce()

func startTimer():
	var time_to_wait = internal_timer
	for mod in modifiers:
		if mod == 0:
			time_to_wait = time_to_wait * 0.8

	$Timer.wait_time = time_to_wait
	$Timer.start()

func _process(delta: float) -> void:
	if(needed_resources.size() > 0):
		retrieve()
	deposit()

func _on_timer_timeout():
	produce()
	startTimer()

func retrieve():
	for i in range(0, needed_resources.size()):
		if(needed_resources[i][1] == true):
			var res = resource_manager.consume(needed_resources[i][0], start, end)
			if(res):
				needed_resources[i][1] = false

func deposit():
	while created_resources.size() > 0:
		var res = resource_manager.deposit(created_resources[0], start, end);
		if (res):
			created_resources.pop_front()
		else:
			break

func create(resource: Res.Type):
	created_resources.append(resource)

func set_base(base_type: TotemPieces.BaseType):
	if(base_type != 1 && base != 1):
		return false
	base = base_type

func add_modifier(modifier_type):
	if(modifiers.size() > 4):
		return false
	modifiers.append(modifier_type)
	
func remove_modifier(modifier_type):
	if(modifiers.size() > 4):
		return false
	modifiers.append(modifier_type)

func produce():
	var can_produce = true
	for resource in needed_resources:
		if(resource[1] == false):
			can_produce == false

	if(can_produce): 
		for action in actions:
			action.call()
