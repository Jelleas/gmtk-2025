extends HBoxContainer

@export var monster_path: MonsterPath

var n_bones: int

func _ready() -> void:
	$CountLabel.text = str(0)
	monster_path.monster_killed.connect(_on_monster_killed)

func _on_monster_killed(monster: Monster) -> void:
	print(monster)
	#n_bones += monster.config
	#$CountLabel
