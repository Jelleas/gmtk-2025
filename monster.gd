extends PathFollow2D

class_name Monster

signal monster_escape(monster: Monster)
signal monster_killed(monster: Monster)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var monster_body: Area2D = $MonsterBody
@onready var health_bar: TextureProgressBar = $TextureProgressBar
@onready var footstep_player = $FootstepPlayer
@onready var voice_player = $MonsterVoice
var camera: Camera2D
const LOOP_SECONDS = 100

var escape_cost: int
var speed: float
var health: int
var frames: SpriteFrames
var previous_position: Vector2
var current_direction: Direction
var original_modulate: Color
var config: MonsterConfig
var is_dead: bool = false
var dots: Array[DotSpec] = []

enum Direction {
	UP, DOWN, LEFT, RIGHT
}

func _ready() -> void:
	previous_position = position
	current_direction = Direction.UP
	original_modulate = modulate
	sprite.sprite_frames = frames
	sprite.speed_scale = speed
	sprite.play("walk_up")
	monster_body.collision_layer = 1
	monster_body.collision_mask = 2
	monster_body.monitoring = true
	monster_body.monitorable = true
	monster_body.add_to_group("monster")
	health_bar.max_value = config.health
	health_bar.value = config.health
	sprite.z_index = 1
	start_damage_cycle()
	sprite.frame_changed.connect(_on_frame_changed)
	camera = get_viewport().get_camera_2d()


func get_hit(incoming_hit: DamageSpec):
	speed += config.speed * incoming_hit.speed_modifier
	take_damage(incoming_hit.damage)
	if(incoming_hit.dot_spec):
		dots.append(DotSpec.new().init(incoming_hit.damage, incoming_hit.type, incoming_hit.dot_spec.stacks_applied))

func start_damage_cycle():
	while true:
		await get_tree().create_timer(1.0).timeout
		if(health > 0):
			dot_tick()

func dot_tick():
	for dot in dots:
		take_damage(dot.damage_per_stack * dot.stacks_applied)
		
		if dot.stacks_fade:
			dot.stacks_applied -= 1

	for i in range(dots.size() - 1, -1, -1):
		if dots[i].stacks_applied == 0:
			dots.remove_at(i)

func _process(delta: float) -> void:
	if is_dead: return
	var direction = (position - previous_position).normalized()
	var cardinal = Vector2(round(direction.x), round(direction.y))
	if direction.length() < 0.1:
		cardinal = Vector2.ZERO
	var new_direction = current_direction
	
	match cardinal:
		Vector2(0, -1):
			new_direction = Direction.UP
		Vector2(1, 0):
			new_direction = Direction.RIGHT
		Vector2(0, 1):
			new_direction = Direction.DOWN
		Vector2(-1, 0):
			new_direction = Direction.LEFT
	
	if new_direction != current_direction:
		current_direction = new_direction
		match new_direction:
			Direction.UP:
				sprite.play("walk_up")
			Direction.RIGHT:
				sprite.play("walk_right")
			Direction.DOWN:
				sprite.play("walk_down")
			Direction.LEFT:
				sprite.play("walk_left")
	previous_position = position
	

func _physics_process(delta: float) -> void:
	if is_dead: return
	progress_ratio += delta / (LOOP_SECONDS / speed)
	
	if progress_ratio >= 1.0:
		escape()

func init(_config: MonsterConfig):
	config = _config
	escape_cost = config.escape_cost
	speed = config.speed
	health = config.health
	frames = config.sprite
	scale = Vector2(config.scale, config.scale)

func take_damage(damage: int):
	health -= damage
	health_bar.value = health
	_flash()
	_play_hit_sound()
	if(health <= 0):
		is_dead = true
		monster_killed.emit(self)
		sprite.stop()
		$MonsterBody.queue_free()
		var tween = get_tree().create_tween()
		tween.tween_property(sprite, "modulate:a", 0.0, 0.5)
		tween.tween_callback(queue_free)

func escape():
	monster_escape.emit(self)
	queue_free()
	
func _flash():
	var tween = create_tween()
	sprite.modulate = Color.RED
	tween.tween_property(sprite, "modulate", original_modulate, 0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

func _play_hit_sound():
	var camera = get_viewport().get_camera_2d()
	var camera_pos = camera.global_position
	var max_distance = 500.0
	var distance = global_position.distance_to(camera_pos)
	var volume = clamp(1.0 - (distance / max_distance), 0.0, 1.0)
	voice_player.volume_db = linear_to_db(volume)
	voice_player.play()

func _on_frame_changed():
	var camera_pos = camera.global_position
	var max_distance = 500.0
	var distance = global_position.distance_to(camera_pos)
	var volume = clamp(1.0 - (distance / max_distance), 0.0, 1.0)
	footstep_player.volume_db = linear_to_db(volume)
	if sprite.frame % 4 == 0:
		footstep_player.play()
