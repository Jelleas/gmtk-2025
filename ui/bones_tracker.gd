extends HBoxContainer

@export var monster_path: MonsterPath

var n_bones: int

func _ready() -> void:
	$CountLabel.text = str(0)
	monster_path.monster_killed.connect(_on_monster_killed)

func _on_monster_killed(monster: Monster) -> void:
	n_bones += monster.config.bones
	$CountLabel.text = str(n_bones)
