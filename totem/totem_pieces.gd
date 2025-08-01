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
}

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY,
	GAMING
}

class Base extends Resource:
	var name: String
	var price: int
	var type: BaseType
	var icon: Sprite2D
	var damage: int
	var cooldown: float
	var crit_chance: float
	var consumes: Array[Res.Type]
	var produces: Array[Res.Type]
	

class Forest extends Base:
	func _init():
		name = "forest"
		price = 100
		type = BaseType.PRODUCER
		icon = Sprite2D.new()
		damage = 0
		cooldown = 5.0
		crit_chance = 0
		consumes = []
		produces = [Res.Type.WOOD]

class Pond extends Base:
	func _init():
		name = "pond"
		price = 100
		type = BaseType.PRODUCER
		icon = Sprite2D.new()
		damage = 0
		cooldown = 10.0
		crit_chance = 0
		consumes = []
		produces = [Res.Type.FROG]

class Dart extends Base:
	func _init():
		name = "dart"
		price = 100
		type = BaseType.DART
		icon = Sprite2D.new()
		damage = 10
		cooldown = 10.0
		crit_chance = 0.05
		consumes = [Res.Type.WOOD]
		produces = []

var base_types: Array[Base] = [
	Dart.new(), Forest.new(), Pond.new()
]

class Modifier extends Resource:
	var name: String
	var price: int
	var description: String
	var type: ModifierType
	var icon: Sprite2D
	var rarity: Rarity
	
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
		#totem_base.energy_cost *= 1 / 0.7
		totem_base.cooldown *= 0.7
		return totem_base

static var modifiers: Array[Modifier] = [
	Speed1.new(),
	Speed2.new(),
	Speed3.new()
]
