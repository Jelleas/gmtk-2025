extends Node2D

var totem: Totem
var is_active = false
var produces: Array[Res.Type]
var consumes: Array[Res.Type]

var damage: int
var crit_chance: float
var cooldown: float
var total_energy: float
var energy_cost: float
var current_energy: float
var range: float

var global_pos: Vector2
var local_pos: Vector2

var locked_target: Area2D
var attack_area: Area2D

func init(parent_ref):
	totem = parent_ref
	produces = totem.base.produces
	consumes = totem.base.consumes
	
	totem.timer.timeout.connect(totem_action)
	
	damage = totem.base.damage
	crit_chance = totem.base.crit_chance
	cooldown = totem.base.cooldown
	total_energy = totem.base.total_energy
	energy_cost = totem.base.energy_cost
	range = totem.base.range
	
	
	totem.damage = totem.base.damage
	totem.crit_chance = totem.base.crit_chance
	totem.cooldown = totem.base.cooldown
	totem.range = totem.base.range
	totem.total_energy = totem.base.total_energy
	totem.energy_cost = totem.base.energy_cost
	totem.produces = totem.base.produces
	totem.consumes = totem.base.consumes

	global_pos = totem.global_pos
	local_pos = totem.local_pos
	
	totem.sprite.modulate = totem.base.sprite_color
	totem.sprite.global_position = global_pos

	attack_area = $AttackArea
	attack_area.global_position = local_pos
	$AttackArea/CollisionShape2D.shape.radius = totem.base.range
	attack_area.area_entered.connect(_on_attack_area_entered)
	attack_area.area_exited.connect(_on_attack_area_exited)
	attack_area.collision_mask = 1
	attack_area.collision_layer = 1
	attack_area.set_physics_process(true)
	attack_area.monitoring = true
	attack_area.monitorable = true
	
	is_active = true
	totem.is_active = true

func _process(delta: float) -> void:
	if !is_active:
		return
	if(current_energy <= energy_cost):
		refill_energy()

func _on_attack_area_entered(body: Node2D) -> void:
	if(!locked_target):
		locked_target = body

func _on_attack_area_exited(body: Node2D) -> void:
	if locked_target == body:
		locked_target = null
		var target_list = attack_area.get_overlapping_bodies()
		if(target_list.size() > 0):
			locked_target = target_list[0]

func refill_energy():
	if(totem.needs_met):
		current_energy = total_energy
		totem.inventory = []
		totem.needs_met = false

func totem_action():
	if(locked_target && current_energy <= energy_cost):
		current_energy -= energy_cost
		drop(local_pos, locked_target)
		
func drop(from: Vector2, target: Area2D):
	print("test")
	var to = totem.tile_map_layer.to_local(target.global_position)
	var projectile_scene = preload("res://totem/frog_bomb/projectile.tscn")
	var proj = projectile_scene.instantiate()
	proj.target = target
	proj.damage = damage
	proj.global_position = to
	add_child(proj)

func apply_modifier(modifier: TotemPieces.Modifier):
	var mod_totem = modifier.apply(totem.base)

	crit_chance = mod_totem.crit_chance
	cooldown = mod_totem.cooldown
	damage = mod_totem.damage
	
	totem.crit_chance = crit_chance
	totem.cooldown = cooldown
	totem.damage = damage
