extends Node2D

class_name Totem

var start: int
var end: int
@export var resource_manager: ResourceManager
var timer: Timer

var actions: Array = []
var needed_resources:Array = []
var created_resources:Array = []
var modifiers: Array = []

var base:TotemPieces.Base
var base_scene: Node2D
var damage: int
var cooldown: float
var crit_chance: float

func init(resource_man: Path2D, start_index: int, end_index: int):
	resource_manager = resource_man
	start = start_index
	end = end_index

	timer = Timer.new()
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func startTimer():
	var time_to_wait = cooldown
	timer.wait_time = time_to_wait
	timer.start()

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

func set_base(new_base: TotemPieces.Base):
	if(base != null && new_base.type != TotemPieces.BaseType.EMPTY && base.type != TotemPieces.BaseType.EMPTY):
		return false
	base = new_base
	
	if(base.type == TotemPieces.BaseType.PRODUCER):
		var base_init = $Producer
		add_child(base_init)
		base_init.init(self)
		base_scene = base_init
	
	startTimer()

func add_modifier(modifier: TotemPieces.Modifier):
	if(modifiers.size() > 4):
		return false
	modifiers.append(modifier)
	base_scene.apply_modifier(modifier)
	
func remove_modifier(modifier_type):
	return

func produce():
	var can_produce = true
	for resource in needed_resources:
		if(resource[1] == false):
			can_produce == false

	if(can_produce): 
		for action in actions:
			action.call()
