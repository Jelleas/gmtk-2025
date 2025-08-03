extends Resource
class_name DamageSpec

enum Type {
	PHYSICAL,
	POISON,
	FIRE,
	VOODOO,
}

@export var damage: int
@export var type: DamageSpec.Type
@export var speed_modifier: float
@export var dot_spec: DotSpec = null

func init(_damage: int, _type: Type, _speed_modifier: float, dot_stacks: int) -> DamageSpec:
	damage = _damage
	type = _type
	speed_modifier = _speed_modifier
	if dot_stacks > 0:
		dot_spec = DotSpec.new().init(damage, type, dot_stacks)
	
	return self
