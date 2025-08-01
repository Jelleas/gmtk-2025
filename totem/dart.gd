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
	
	totem.damage = totem.base.damage
	totem.crit_chance = totem.base.crit_chance
	totem.cooldown = totem.base.cooldown
	totem.total_energy = totem.base.total_energy
	totem.energy_cost = totem.base.energy_cost
	totem.produces = totem.base.produces
	totem.consumes = totem.base.consumes
	
	is_active = true
	totem.is_active = true

func _process(delta: float) -> void:
	if !is_active:
		return
	if(current_energy <= energy_cost):
		refill_energy()

func refill_energy():
	if(totem.needs_met):
		current_energy = total_energy
		totem.inventory = []
		totem.needs_met = false

func totem_action():
	if(current_energy >= energy_cost):
		current_energy -= energy_cost
		print("PEW PEW PEW")

func apply_modifier(modifier: TotemPieces.Modifier):
	var mod_totem = modifier.apply(totem.base)

	crit_chance = mod_totem.crit_chance
	cooldown = mod_totem.cooldown
	
	totem.crit_chance = crit_chance
	totem.cooldown = cooldown
