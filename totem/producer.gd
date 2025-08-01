extends Node2D

var totem: Totem
var produces: Array[Res.Type]

var damage: int
var crit_chance: float
var cooldown: float
var total_energy: float
var energy_cost: float
var current_energy: float

func init(parent_ref):
	totem = parent_ref
	produces = totem.base.produces
	totem.timer.timeout.connect(refill_energy)
	
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

func _process(delta: float) -> void:
	if(current_energy >= energy_cost):
		for resource in produces:
			totem.created_resources.append(resource)
	current_energy -= energy_cost

func refill_energy():
	current_energy = total_energy


func apply_modifier(modifier: TotemPieces.Modifier):
	var mod_totem = modifier.apply(totem.base)

	crit_chance = mod_totem.crit_chance
	cooldown = mod_totem.cooldown
	
	totem.crit_chance = crit_chance
	totem.cooldown = cooldown
