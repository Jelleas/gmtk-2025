extends Node2D

var totem: Totem
var resource: Res.Type

var damage: int
var crit_chance: float
var cooldown: float
var total_energy: float
var energy_cost: float

func init(parent_ref):
	totem = parent_ref
	resource = totem.base.produces[0]
	totem.timer.timeout.connect(create_resource)
	
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

func create_resource():
	totem.created_resources.append(resource)

func apply_modifier(modifier: TotemPieces.Modifier):
	var mod_totem = modifier.apply(totem.base)

	crit_chance = mod_totem.crit_chance
	cooldown = mod_totem.cooldown
	
	totem.crit_chance = crit_chance
	totem.cooldown = cooldown
