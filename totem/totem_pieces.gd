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

var BaseTypes: Array[Base] = [
	Dart.new()
]

class Modifier extends Resource:
	var name: String
	var price: int
	var type: ModifierType
	var icon: Sprite2D
	var rarity: Rarity
	var consumes: Array[Res.Type]
	var produces: Array[Res.Type]
	
	func apply(_totem_base):
		push_error("Modifier subclass must implement 'apply()'")

class Speed1 extends Modifier:
	func _init():
		name = "speed"
		price = 100
		type = ModifierType.SPEED
		icon = Sprite2D.new()
		rarity = Rarity.COMMON
		consumes = [Res.Type.WOOD]
		produces = []
				
	func apply(totem_base):
		totem_base.cooldown *= 0.8
		

var modifiers: Array[Modifier] = [
	Speed1.new()
]
