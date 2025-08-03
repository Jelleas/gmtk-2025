extends HBoxContainer

class_name BonesTracker

signal bones_updated()

@export var monster_path: MonsterPath

var n_bones: int = 1000

func _ready() -> void:
	$CountLabel.text = str(n_bones)
	$TextureRect.texture = get_bones_image()
	monster_path.monster_killed.connect(_on_monster_killed)

func _on_monster_killed(monster: Monster) -> void:
	n_bones += monster.config.bones
	$CountLabel.text = str(n_bones)
	bones_updated.emit()
	
func has(bone_amount: int) -> bool:
	return n_bones >= bone_amount

func spend(bone_amount: int) -> bool:
	if n_bones < bone_amount:
		return false
	n_bones -= bone_amount
	$CountLabel.text = str(n_bones)
	return true

static func get_bones_image(width: int = 40, height: int = 40) -> ImageTexture:
	var resource = load("res://assets/resources/bone.png")
	var image = resource.get_image()
	image.resize(width, height, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)
