extends Node2D

class_name Tower

@export var start: int
@export var end: int
@export var resource_manager: Path2D
@export var internal_timer: float = 10.0

var actions: Array = []
var needed_resources:Array = []
var created_resources:Array = []

func init(resource_man: Path2D, resource: Res.Type, start_index: int, end_index: int):
	resource_manager = resource_man
	start = start_index
	end = end_index
	if(resource != -1):
		actions.append(func() -> void: create(resource))

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)

func set_internal_timer_length(timer: float):
	internal_timer = timer

func startTimer():
	$Timer.wait_time = internal_timer
	$Timer.start()

func _process(delta: float) -> void:
	var canProduce = true
	for resource in needed_resources:
		if(resource[1] == false):
			canProduce == false
			
	if(canProduce && $Timer.is_stopped()):
		startTimer()
		produce()
	
	if(needed_resources.size() > 0):
		retrieve()

	deposit()

func _on_timer_timeout():
	produce()

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
	
func add_upgrade():
	needed_resources.append([Res.Type.WOOD, true])
	needed_resources.append([Res.Type.WOOD, true])
	actions.append(func() -> void: two_to_one())

func two_to_one():
	if(needed_resources[0][1] == false && needed_resources[1][1] == false):
		create(Res.Type.FROG)
		needed_resources[0][1] = true
		needed_resources[1][1] = true

func produce():
	for action in actions:
		action.call()
