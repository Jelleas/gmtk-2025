extends Resource

class_name TotemPieces

enum BaseType {
	EMPTY,
	PRODUCER,
	CONVERTER,
	DART,
	FROGBOMB,
	SWAMP,
	VOODOO,
}

enum ModifierType {
	SPEED,
	CRIT,
	RANGE,
	ENERGY_COST,
	POWER
}

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY,
	GAMING
}

class TotemPiece extends Resource:
	var name: String
	var price: int
	var icon: Resource
	var description: String
	var rarity: Rarity

class TotemBase extends TotemPiece:
	var type: BaseType
	var sprite_color: Color
	var damage: int
	var cooldown: float
	var crit_chance: float
	var range: float
	var consumes: Array[Res.Type]
	var produces: Array[Res.Type]
	var total_energy: float
	var energy_cost: float
	var is_base_type = true

class Forest extends TotemBase:
	func _init():
		name = "Forest"
		description = "A dense, ancient forest teeming with towering trees and wildlife. Rich in timber, it's a vital source of wood."
		price = 100
		type = BaseType.PRODUCER
		icon = load("res://assets/totems/forest.png")
		sprite_color = Color.html("#046620")
		damage = 0
		cooldown = 5.0
		crit_chance = 0
		consumes = []
		produces = [Res.Type.WOOD]
		total_energy = 100.0
		energy_cost = 0
		range = 0.0

class Pond extends TotemBase:
	func _init():
		name = "Pond"
		description = "A quiet, shallow pond nestled among reeds and lilies. Its calm waters are home to a thriving population of frogs."
		price = 100
		type = BaseType.PRODUCER
		icon = load("res://assets/totems/pond.png")
		sprite_color = Color.html("#42c2f5")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = []
		produces = [Res.Type.FROG]
		total_energy = 100.0
		energy_cost = 0
		range = 0.0

class MossValley extends TotemBase:
	func _init():
		name = "Moss valley"
		description = "A damp, misty valley carpeted in thick, emerald moss. Soft underfoot and rich in mushrooms."
		price = 100
		type = BaseType.PRODUCER
		icon = load("res://assets/totems/moss-valley.png")
		sprite_color = Color.html("#D62828")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = []
		produces = [Res.Type.SHROOM]
		total_energy = 100.0
		energy_cost = 0
		range = 0.0

class Shrubbery extends TotemBase:
	func _init():
		name = "Shubbery"
		description = "A modest yet well-kept patch of ornamental bushes containing berries. The Knights who say “Ni!” would be most pleased."
		price = 100
		type = BaseType.PRODUCER
		icon = load("res://assets/totems/shrubbery.png")
		sprite_color = Color.html("#C21807")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = []
		produces = [Res.Type.BERRY]
		total_energy = 100.0
		energy_cost = 0
		range = 0.0

class FrogBurner extends TotemBase:
	func _init():
		name = "Frog burner"
		description = "Converts frogs into crispy frogs."
		price = 100
		type = BaseType.PRODUCER
		icon = load("res://assets/totems/frog-burner.png")
		sprite_color = Color.html("#FF6B00")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = [Res.Type.FROG]
		produces = [Res.Type.CRISPY_FROG]
		total_energy = 100.0
		energy_cost = 100
		range = 0.0

class FrogSkinner extends TotemBase:
	func _init():
		name = "Frog skinner"
		description = "Converts frogs into frog skin."
		price = 100
		type = BaseType.CONVERTER
		icon = load("res://assets/totems/frog-skinner.png")
		sprite_color = Color.html("#4A9153")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = [Res.Type.FROG]
		produces = [Res.Type.FROG_SKIN]
		total_energy = 100.0
		energy_cost = 100
		range = 0.0

class BerryJuicer extends TotemBase:
	func _init():
		name = "Berry juicer"
		description = "We do not need the berries, just the juice exile."
		price = 100
		type = BaseType.CONVERTER
		icon = load("res://assets/totems/berry-juicer.png")
		sprite_color = Color.html("#C21807")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = [Res.Type.BERRY]
		produces = [Res.Type.BERRY_JUICE]
		total_energy = 100.0
		energy_cost = 100
		range = 0.0

class ShroomMulcher extends TotemBase:
	func _init():
		name = "Shroom mulcher"
		description = "Mulches shrooms to dust, magic dust."
		price = 100
		type = BaseType.CONVERTER
		icon = load("res://assets/totems/shroom-mulcher.png")
		sprite_color = Color.html("#2E2E2E")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = [Res.Type.SHROOM]
		produces = [Res.Type.MAGIC_DUST]
		total_energy = 100.0
		energy_cost = 100
		range = 0.0

class PotionStation extends TotemBase:
	func _init():
		name = "Potion Station"
		description = "Brews potions out of magic dust and berry juice."
		price = 100
		type = BaseType.CONVERTER
		icon = load("res://assets/totems/potion-station.png")
		sprite_color = Color.html("#2E2E2E")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = [Res.Type.MAGIC_DUST, Res.Type.BERRY_JUICE]
		produces = [Res.Type.POTION]
		total_energy = 100.0
		energy_cost = 100
		range = 0.0

class Dart1 extends TotemBase:
	func _init():
		name = "Dart"
		description = "Consumes wood to shoot darts."
		price = 100
		type = BaseType.DART
		icon = load("res://assets/totems/speed-l.png")
		sprite_color = Color.html("#A0522D")
		damage = 10
		cooldown = 1.0
		crit_chance = 0.05
		consumes = [Res.Type.WOOD]
		produces = []
		total_energy = 100.0
		energy_cost = 10.0
		range = 600.0

class Dart2 extends TotemBase:
	func _init():
		name = "Poison Dart"
		description = "Consumes wood and frogs to shoot poison darts."
		price = 200
		type = BaseType.DART
		icon = load("res://assets/totems/speed-l.png")
		sprite_color = Color.html("#A0522D")
		damage = 20
		cooldown = 1.0
		crit_chance = 0.05
		consumes = [Res.Type.WOOD, Res.Type.FROG]
		produces = []
		total_energy = 100.0
		energy_cost = 10.0
		range = 600.0
		
class FrogBomb extends TotemBase:
	func _init():
		name = "Frog Bomb"
		description = "Drops a big frog on enemies."
		price = 300
		type = BaseType.FROGBOMB
		icon = load("res://assets/totems/speed-l.png")
		sprite_color = Color.html("#ebdf0c")
		damage = 50
		cooldown = 3.0
		crit_chance = 0.10
		consumes = [Res.Type.FROG]
		produces = []
		total_energy = 100.0
		energy_cost = 20.0
		range = 600.0
		
class Swamp extends TotemBase:
	func _init():
		name = "Swamp"
		price = 400
		type = BaseType.SWAMP
		icon = load("res://assets/totems/speed-l.png")
		sprite_color = Color.html("#70543E")
		damage = 1
		cooldown = 10
		crit_chance = 0.10
		consumes = [Res.Type.SHROOM]
		produces = []
		total_energy = 100.0
		energy_cost = 5.0
		range = 600.0

static var base_types: Array[TotemBase] = [
	Dart1.new(),
	Dart2.new(),
	Swamp.new(),
	FrogBomb.new(), 
	FrogBurner.new(), 
	FrogSkinner.new(), 
	ShroomMulcher.new(), 
	BerryJuicer.new(), 
	PotionStation.new()
]

class Modifier extends TotemPiece:
	var is_base_type = false
	var type: ModifierType
	
	func apply(_totem_base):
		push_error("Modifier subclass must implement 'apply()'")

class Speed1 extends Modifier:
	func _init():
		name = "Speed 1"
		price = 100
		description = "Activate the totem 10% faster"
		type = ModifierType.SPEED
		icon = load("res://assets/totems/speed-l.png")
		rarity = Rarity.COMMON
				
	func apply(totem_base):
		#totem_base.energy_cost *= 1 / 0.9
		totem_base.cooldown *= 0.9
		return totem_base

class Speed2 extends Modifier:
	func _init():
		name = "Speed 2"
		price = 200
		description = "Activate the totem 20% faster"
		type = ModifierType.SPEED
		icon = load("res://assets/totems/speed-l.png")
		rarity = Rarity.RARE
				
	func apply(totem_base):
		#totem_base.energy_cost *= 1 / 0.8
		totem_base.cooldown *= 0.8
		return totem_base

class Speed3 extends Modifier:
	func _init():
		name = "Speed 3"
		price = 300
		description = "Activate the totem 30% faster"
		type = ModifierType.SPEED
		icon = load("res://assets/totems/speed-l.png")
		rarity = Rarity.EPIC
				
	func apply(totem_base):
		totem_base.cooldown *= 0.7
		return totem_base
		
class Crit1 extends Modifier:
	func _init():
		name = "Crit 1"
		price = 100
		description = "Increase chance of critical strikes by 5%"
		type = ModifierType.CRIT
		icon = load("res://assets/totems/crit-l.png")
		rarity = Rarity.COMMON
				
	func apply(totem_base):
		totem_base.crit_chance += 0.05
		return totem_base

class Crit2 extends Modifier:
	func _init():
		name = "Crit 2"
		price = 200
		description = "Increase chance of critical strikes by 10%"
		type = ModifierType.CRIT
		icon = load("res://assets/totems/crit-l.png")
		rarity = Rarity.RARE
				
	func apply(totem_base):
		totem_base.crit_chance += 0.10
		return totem_base

class Crit3 extends Modifier:
	func _init():
		name = "Crit 3"
		price = 300
		description = "Increase chance of critical strikes by 20%"
		type = ModifierType.CRIT
		icon = load("res://assets/totems/crit-l.png")
		rarity = Rarity.EPIC

	func apply(totem_base):
		totem_base.crit_chance += 0.20
		return totem_base

class Range1 extends Modifier:
	func _init():
		name = "Range 1"
		price = 100
		description = "Increase range by 10%"
		type = ModifierType.RANGE
		icon = load("res://assets/totems/power-l.png")
		rarity = Rarity.COMMON

	func apply(totem_base):
		totem_base.range *= 1.10
		return totem_base

class Range2 extends Modifier:
	func _init():
		name = "Range 2"
		price = 200
		description = "Increase range by 20%"
		type = ModifierType.RANGE
		icon = load("res://assets/totems/power-l.png")
		rarity = Rarity.RARE

	func apply(totem_base):
		totem_base.range *= 1.20
		return totem_base

class Range3 extends Modifier:
	func _init():
		name = "Range 3"
		price = 300
		description = "Increase range by 30%"
		type = ModifierType.RANGE
		icon = load("res://assets/totems/power-l.png")
		rarity = Rarity.EPIC

	func apply(totem_base):
		totem_base.range *= 1.30
		return totem_base

class EnergyCost1 extends Modifier:
	func _init():
		name = "Energy 1"
		price = 100
		description = "Reduces energy consumption by 5%"
		type = ModifierType.ENERGY_COST
		icon = load("res://assets/totems/energy-l.png")
		rarity = Rarity.COMMON

	func apply(totem_base):
		totem_base.energy_cost *= 0.95
		return totem_base

class EnergyCost2 extends Modifier:
	func _init():
		name = "Energy 2"
		price = 200
		description = "Reduces energy consumption by 10%"
		type = ModifierType.ENERGY_COST
		icon = load("res://assets/totems/energy-l.png")
		rarity = Rarity.RARE

	func apply(totem_base):
		totem_base.energy_cost *= 0.90
		return totem_base
	
class EnergyCost3 extends Modifier:
	func _init():
		name = "Energy 3"
		price = 300
		description = "Reduces energy consumption by 20%"
		type = ModifierType.ENERGY_COST
		icon = load("res://assets/totems/energy-l.png")
		rarity = Rarity.EPIC

	func apply(totem_base):
		totem_base.energy_cost *= 0.80
		return totem_base

class Power1 extends Modifier:
	func _init():
		name = "Power 1"
		price = 100
		description = "Increases power by 10%"
		type = ModifierType.POWER
		icon = load("res://assets/totems/power-l.png")
		rarity = Rarity.COMMON

	func apply(totem_base):
		totem_base.damage *= 1.10
		return totem_base

class Power2 extends Modifier:
	func _init():
		name = "Power 2"
		price = 200
		description = "Increases power by 20%"
		type = ModifierType.POWER
		icon = load("res://assets/totems/power-l.png")
		rarity = Rarity.COMMON

	func apply(totem_base):
		totem_base.damage *= 1.20
		return totem_base

class Power3 extends Modifier:
	func _init():
		name = "Power 3"
		price = 300
		description = "Increases power by 30%"
		type = ModifierType.POWER
		icon = load("res://assets/totems/power-l.png")
		rarity = Rarity.COMMON

	func apply(totem_base):
		totem_base.damage *= 1.30
		return totem_base


static var modifiers: Array[Modifier] = [
	Speed1.new(),
	Speed2.new(),
	Speed3.new(),
	Crit1.new(),
	Crit2.new(),
	Crit3.new(),
	Range1.new(),
	Range2.new(),
	Range3.new(),
	EnergyCost1.new(),
	EnergyCost2.new(),
	EnergyCost3.new(),
	Power1.new(),
	Power2.new(),
	Power3.new()
]
