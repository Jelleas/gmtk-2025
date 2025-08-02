extends Resource

class_name TotemPieces

enum BaseType {
	EMPTY,
	PRODUCER,
	DART,
	FROGBOMB,
	SWAMP,
	VOODOO,
}

enum ModifierType {
	SPEED,
	CRIT,
	RANGE,
	ENERGY_COST
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
	var icon: Sprite2D
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
		price = 100
		type = BaseType.PRODUCER
		icon = Sprite2D.new()
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
		price = 100
		type = BaseType.PRODUCER
		icon = Sprite2D.new()
		sprite_color = Color.html("#42c2f5")
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = []
		produces = [Res.Type.FROG]
		total_energy = 100.0
		energy_cost = 0
		range = 0.0

class Dart extends TotemBase:
	func _init():
		name = "Dart"
		price = 100
		type = BaseType.DART
		icon = Sprite2D.new()
		sprite_color = Color.html("#A0522D")
		damage = 10
		cooldown = 1.0
		crit_chance = 0.05
		consumes = [Res.Type.WOOD]
		produces = []
		total_energy = 100.0
		energy_cost = 10.0
		range = 600.0
		
class FrogBomb extends TotemBase:
	func _init():
		name = "Frog Bomb"
		price = 300
		type = BaseType.FROGBOMB
		icon = Sprite2D.new()
		sprite_color = Color.html("#ebdf0c")
		damage = 50
		cooldown = 3.0
		crit_chance = 0.10
		consumes = [Res.Type.FROG]
		produces = []
		total_energy = 100.0
		energy_cost = 20.0
		range = 600.0

static var base_types: Array[TotemBase] = [
	Dart.new(), FrogBomb.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
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
		icon = Sprite2D.new()
		rarity = Rarity.EPIC

	func apply(totem_base):
		totem_base.energy_cost *= 0.80
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
]
