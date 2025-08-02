extends Path2D

class_name MonsterPath

signal monster_escape(monster: Monster)
signal monster_killed(monster: Monster)

@export var monster_scene: PackedScene
@export var wave_seconds: float = 10
@export var wave_rest_seconds: float = 5
@export var monster_configs: Array[MonsterConfig]

@onready var wave_timer: Timer = $WaveTimer
@onready var spawn_timer: Timer = $SpawnTimer

var monsters: Array[Monster]
var monsters_to_spawn: Array[MonsterConfig]
var current_wave: int = 0
var current_rank: int = 0

func _ready() -> void:
	wave_timer.timeout.connect(_start_new_wave)
	wave_timer.start(wave_seconds + wave_rest_seconds)
	spawn_timer.timeout.connect(_spawn_new_monster)
	_start_new_wave()
	
func _process(delta: float) -> void:
	pass

func spawn(config: MonsterConfig):
	var monster = monster_scene.instantiate()
	monster.init(config)
	add_child(monster)
	
	monsters.append(monster)
	
	monster.monster_escape.connect(_on_monster_escape)
	monster.monster_killed.connect(_on_monster_killed)
	
func _on_monster_escape(monster: Monster) -> void:
	monster_escape.emit(monster)

func _on_monster_killed(monster: Monster) -> void:
	monster_killed.emit(monster)

func _on_child_exiting_tree(node: Node) -> void:
	monsters.erase(node)
	
func _spawn_new_monster():
	var monster = monsters_to_spawn.pop_front()
	if monster == null:
		spawn_timer.stop()
		return
	spawn(monster)
	
func _start_new_wave():
	print("spawning new wave")
	current_wave += 1
	current_rank += 5
	var max_monster_rank = current_rank / 3
	var picked_rank = 0
	while picked_rank < current_rank: 
		var available_rank = current_rank - picked_rank
		var monster = _pick_random_monster(mini(available_rank, max_monster_rank))
		picked_rank += monster.rank
		monsters_to_spawn.append(monster)
	
	spawn_timer.start(wave_seconds / (monsters_to_spawn.size() - 1))
	_spawn_new_monster()
		
		
func _pick_random_monster(max_rank: int) -> MonsterConfig:
	var available_monsters = monster_configs.filter(func(config: MonsterConfig): return config.rank <= max_rank)
	var random_index = randi_range(0, available_monsters.size() - 1)
	return available_monsters[random_index]
