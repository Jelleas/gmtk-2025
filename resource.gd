extends PathFollow2D

class_name Res

enum Type {
	BERRY,
	CRISPY_FROG,
	DUST,
	FROG_SKIN,
	FROG,
	MAGIC_DUST,
	POTION,
	SHROOM,
	WOOD
}

@onready var sprite: Sprite2D = $Sprite2D
var type: Res.Type
#
func init(type_: Res.Type, progress_ratio_: float):
	progress_ratio = progress_ratio_
	type = type_
	match type:
		Type.BERRY: sprite.texture = load("res://assets/resources/berry.png")
		Type.CRISPY_FROG: sprite.texture = load("res://assets/resources/crispy-frog.png")
		Type.DUST: sprite.texture = load("res://assets/resources/dust.png")
		Type.FROG_SKIN: sprite.texture = load("res://assets/resources/frog-skin.png")
		Type.FROG: sprite.texture = load("res://assets/resources/frog.png")
		Type.MAGIC_DUST: sprite.texture = load("res://assets/resources/magic-dust.png")
		Type.POTION: sprite.texture = load("res://assets/resources/potion.png")
		Type.SHROOM: sprite.texture = load("res://assets/resources/shroom.png")
		Type.WOOD: sprite.texture = load("res://assets/resources/wood.png")
