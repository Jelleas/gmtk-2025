extends Resource
class_name DotSpec

@export var damage_per_stack: int
@export var type: DamageSpec.Type
@export var stacks_applied: int
@export var stacks_fade: bool = true

func init(_damage: int, _type: DamageSpec.Type, _stacks_applied: int) -> DotSpec:
	match _type:
		DamageSpec.Type.FIRE:
			damage_per_stack = _damage * 0.15
		DamageSpec.Type.POISON:
			damage_per_stack = _damage * 0.1
		DamageSpec.Type.VOODOO:
			damage_per_stack = _damage * 0.05
			stacks_fade = false

	type = _type
	stacks_applied = _stacks_applied
	return self
