extends Node2D

class_name Totem

var start: int
var end: int
var plot_position: Vector2
@export var resource_manager: ResourceManager
@export var tile_map_layer: TileMapLayer
var timer: Timer

var actions: Array = []
var inventory: Array[Res.Type] = []
var created_resources:Array = []
var modifiers: Array = []

var base:TotemPieces.TotemBase
var base_scene: Node2D
var damage: int
var cooldown: float
var crit_chance: float
var range: float
var total_energy: float
var energy_cost: float
var produces: Array[Res.Type] = []
var consumes: Array[Res.Type] = []
var needs_met: bool = false
var is_active: bool = false

func init(resource_man: Path2D, start_index: int, end_index: int, tile_map: TileMapLayer, plot_pos: Vector2):
	resource_manager = resource_man
	start = start_index
	end = end_index
	
	tile_map_layer = tile_map
	plot_position = plot_pos

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
	if (!is_active):
		return
	if(!needs_met):
		retrieve()
	deposit()

func _on_timer_timeout():
	startTimer()

func check_needed():
	var copy_needed = consumes.duplicate()
	for item in inventory:
		if item in copy_needed:
			copy_needed.erase(item)
	return copy_needed

func retrieve():
	var needed = check_needed()
	if(needed.size() == 0):
		needs_met = true
		return

	for resource in needed:
		var res = resource_manager.consume(resource, start, end)
		if (res):
			inventory.append(resource)
		

func deposit():
	while created_resources.size() > 0:
		var res = resource_manager.deposit(created_resources[0], start, end);
		if (res):
			created_resources.pop_front()
		else:
			break

func set_base(new_base: TotemPieces.TotemBase):
	if(base != null && new_base.type != TotemPieces.BaseType.EMPTY && base.type != TotemPieces.BaseType.EMPTY):
		return false
	base = new_base
	
	if(base.type == TotemPieces.BaseType.PRODUCER):
		var base_init = $Producer
		base_init.init(self)
		base_scene = base_init
		
	if(base.type == TotemPieces.BaseType.DART):
		var base_init = $Dart
		base_init.init(self)
		base_scene = base_init
	
	startTimer()

func add_modifier(modifier: TotemPieces.Modifier):
	modifiers.append(modifier)
	base_scene.apply_modifier(modifier)
	
func remove_base():
	base = null
	
func remove_modifier(modifier_type):
	var i = modifiers.find(modifier_type)
	modifiers.remove_at(i)
