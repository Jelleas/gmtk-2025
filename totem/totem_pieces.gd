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
	var icon: Sprite2D
	var rarity: Rarity
	
	func apply(_totem_base):
		push_error("Modifier subclass must implement 'apply()'")

class Speed1 extends Modifier:
	func _init():
		name = "speed"
		price = 100
		type = ModifierType.SPEED
		icon = Sprite2D.new()
		rarity = Rarity.COMMON
				
	func apply(totem_base):
		totem_base.cooldown *= 0.8
		

var modifiers: Array[Modifier] = [
	Speed1.new()
]
