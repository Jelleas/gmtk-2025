extends Node2D

class_name Totem

signal TotemChanged(totem: Totem)

@export var producer_scene: PackedScene
@export var dart_scene: PackedScene
@export var frog_scene: PackedScene

var start: int
var end: int
var plot_position: Vector2
@export var resource_manager: ResourceManager
@export var tile_map_layer: TileMapLayer
var timer: Timer
var sprite: Sprite2D
var local_pos: Vector2
var global_pos: Vector2

var actions: Array = []
var inventory: Array[Res.Type] = []
var created_resources:Array = []
var modifiers: Array = []

var base:TotemPieces.TotemBase
var modified_base: TotemPieces.TotemBase
var base_scene: Node2D
var current_energy: float
var total_energy: float
var needs_met: bool = false

func init(resource_man: Path2D, start_index: int, end_index: int, tile_map: TileMapLayer, plot_pos: Vector2):
	resource_manager = resource_man
	start = start_index
	end = end_index
	
	current_energy = 100
	
	tile_map_layer = tile_map
	plot_position = plot_pos
	
	sprite = $BaseSprite
	
	var tile_size = tile_map_layer.tile_set.tile_size
	local_pos = tile_map_layer.map_to_local(plot_position)
	global_pos = tile_map_layer.to_global(local_pos)
	
	sprite.global_position = global_pos
	
	timer = Timer.new()
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func startTimer():
	var time_to_wait = modified_base.cooldown
	timer.wait_time = time_to_wait
	timer.start()

func _process(delta: float) -> void:
	if (base == null):
		return
	if(!needs_met):
		retrieve()
	deposit()
	
	if(current_energy <= modified_base.energy_cost):
		refill_energy()

func refill_energy():
	if(needs_met):
		current_energy = modified_base.total_energy
		inventory = []
		needs_met = false

func _on_timer_timeout():
	if (current_energy >= modified_base.energy_cost):
		if base_scene.totem_action(modified_base):
			current_energy -= modified_base.energy_cost
	startTimer()
	
func check_needed():
	var copy_needed = modified_base.consumes.duplicate()
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
	
	var base_init
	match base.type:
		TotemPieces.BaseType.PRODUCER:
			base_init = producer_scene.instantiate()
		TotemPieces.BaseType.DART:
			base_init = dart_scene.instantiate()
		TotemPieces.BaseType.FROGBOMB:
			base_init = frog_scene.instantiate()

	base_init.init(self)
	base_scene = base_init
	
	add_child(base_scene)
	
	set_modified_base()
	
	startTimer()
	
	TotemChanged.emit(self)

func add_modifier(modifier: TotemPieces.Modifier):
	modifiers.append(modifier)
	set_modified_base()
	TotemChanged.emit(self)
	
func remove_base():
	base = null
	modified_base = null
	TotemChanged.emit(self)
	
func remove_modifier(modifier_type):
	var i = modifiers.find(modifier_type)
	modifiers.remove_at(i)
	
	set_modified_base()
	
	TotemChanged.emit(self)

func set_modified_base():
	var base_ = base.duplicate()
		
	for mod in modifiers:
		mod.apply(base_)
	
	modified_base = base_


func name() -> String:
	if base == null:
		return "Empty"
	return base.name
	
func get_total_energy() -> int:
	if modified_base == null:
		return 0
	return modified_base.total_energy
	
func get_current_energy() -> int:
	if modified_base == null:
		return 0
	return current_energy

func get_consumes() -> Array[Res.Type]:
	if modified_base == null:
		return []
	return modified_base.consumes

func get_produces() -> Array[Res.Type]:
	if modified_base == null:
		return []
	return modified_base.produces

func get_crit() -> float:
	if modified_base == null:
		return 0
	return modified_base.crit_chance

func get_damage() -> float:
	if modified_base == null:
		return 0
	return modified_base.damage

func get_cooldown() -> float:
	if modified_base == null:
		return 0
	return modified_base.cooldown

func get_range() -> float:
	if modified_base == null:
		return 0
	return modified_base.range

func get_energy_cost() -> float:
	if modified_base == null:
		return 0
	return modified_base.energy_cost
