extends Resource
class_name DamageSpec

enum Type {
	PHYSICAL,
	NATURE,
	POISON,
	FIRE,
}

@export var damage: int
@export var type: DamageSpec.Type
@export var speed_modifier: float
