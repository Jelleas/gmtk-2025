extends Node2D

var totem: Totem

var global_pos: Vector2
var local_pos: Vector2

func init(parent_ref):
	totem = parent_ref

	global_pos = totem.global_pos
	local_pos = totem.local_pos
	
	totem.sprite.modulate = totem.base.sprite_color

func totem_action(base: TotemPieces.TotemBase) -> bool:
	for resource in base.produces:
		if(randf() < base.crit_chance):
			totem.created_resources.append(resource)
		totem.created_resources.append(resource)
	return true
