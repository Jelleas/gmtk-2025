extends PathFollow2D

class_name Res

enum Type {
	BERRY_JUICE,
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

static func type_to_image_path(_type: Res.Type) -> String:
	match _type:
		Type.BERRY_JUICE: return "res://assets/resources/berry-juice.png"
		Type.BERRY: return "res://assets/resources/berry.png"
		Type.CRISPY_FROG: return "res://assets/resources/crispy-frog.png"
		Type.DUST: return "res://assets/resources/dust.png"
		Type.FROG_SKIN: return "res://assets/resources/frog-skin.png"
		Type.FROG: return "res://assets/resources/frog.png"
		Type.MAGIC_DUST: return"res://assets/resources/magic-dust.png"
		Type.POTION: return "res://assets/resources/potion.png"
		Type.SHROOM: return "res://assets/resources/shroom.png"
		Type.WOOD: return "res://assets/resources/wood.png"
		_: return ""

@onready var sprite: Sprite2D = $Sprite2D
var type: Res.Type
#
func init(type_: Res.Type, progress_ratio_: float):
	progress_ratio = progress_ratio_
	type = type_
	sprite.texture = load(type_to_image_path(type))
	
