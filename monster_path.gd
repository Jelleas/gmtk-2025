extends Path2D

class_name MonsterPath

signal monster_escape(monster: Monster)
signal monster_killed(monster: Monster)
signal wave_started(wave_number: int, next_wave_in: float)

@export var monster_scene: PackedScene
@export var wave_seconds: float = 30
@export var wave_rest_seconds: float = 10
@export var initial_rest: float = 7
@export var monster_configs: Array[MonsterConfig]

@onready var wave_timer: Timer = $WaveTimer
@onready var spawn_timer: Timer = $SpawnTimer
@onready var initial_rest_timer: Timer = $InitialRestTimer

var monsters: Array[Monster]
var monsters_to_spawn: Array[MonsterConfig]
var current_wave: int = 0
var current_max_cost: int = 10

func _ready() -> void:
	wave_timer.timeout.connect(_start_new_wave)
	initial_rest_timer.timeout.connect(_start_game)
	spawn_timer.timeout.connect(_spawn_new_monster)
	initial_rest_timer.one_shot = true
	initial_rest_timer.start(initial_rest)
	
	# wait till all ready, then send the initial wave
	wave_started.emit.call_deferred(0, initial_rest)
	
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
	current_wave += 1
	current_max_cost = int(current_max_cost * 1.1 + 5)
	
	var picked_cost = 0
	while picked_cost < current_max_cost: 
		var available_cost = current_max_cost - picked_cost
		var monster = _pick_random_monster(available_cost, current_wave)
		picked_cost += monster.cost
		monsters_to_spawn.append(monster)
	
	spawn_timer.start(wave_seconds / (monsters_to_spawn.size() - 1))
	_spawn_new_monster()
	wave_started.emit(current_wave, wave_seconds + wave_rest_seconds)
		
func _start_game():
	wave_timer.start(wave_seconds + wave_rest_seconds)
	_start_new_wave()
		
func _pick_random_monster(max_cost: int, current_wave: int) -> MonsterConfig:
	var available_monsters = monster_configs.filter(
		func(config: MonsterConfig): return config.cost <= max_cost and config.rank <= current_wave
	)
	var random_index = randi_range(0, available_monsters.size() - 1)
	return available_monsters[random_index]
