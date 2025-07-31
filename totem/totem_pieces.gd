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
	DAISYDAIRY,
}

class Base extends Resource:
	var name: String
	var price: int
	var type: BaseType
	var icon: Sprite2D
	var damage: int
	var cooldown: float
	var crit_chance: float
	
	func _init(_name: String, _price: int, _type: BaseType, _icon: Sprite2D, _damage: int, _cooldown: float, _crit_chance: float):
		name = _name
		price = _price
		type = _type
		icon = _icon
		damage = _damage
		cooldown = _cooldown
		crit_chance = _crit_chance

var BaseTypes: Array[Base] = [
	Base.new("dart", 100, BaseType.DART, Sprite2D.new(), 20, 10.0, 0.05)
]

class Modifier extends Resource:
	var name: String
	var price: int
	var type: ModifierType
	var icon: Resource
	var modifiers: Array[Callable]
	var rarity: Rarity
	
	func _init(_name: String, _price: int, _type: ModifierType, _icon: Resource, _modifiers: Array, _rarity: Rarity):
		name = _name
		price = _price
		type = _type
		icon = _icon
		modifiers = _modifiers
		rarity = _rarity
		

var modifiers: Array[Modifier] = [
	Modifier.new("speed", 100, ModifierType.SPEED, load("res://path/to/your/image.png"), [func(bt): bt.cooldown *= 0.8], Rarity.COMMON)
]
