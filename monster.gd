extends PathFollow2D

class_name Monster

signal monster_escape(monster: Monster)
signal monster_killed(monster: Monster)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var monster_body: Area2D = $MonsterBody

const LOOP_SECONDS = 100

var escape_cost: int
var speed: int
var health: int
var frames: SpriteFrames

func _ready() -> void:
	sprite.sprite_frames = frames
	sprite.play("default")
	monster_body.collision_layer = 1
	monster_body.collision_mask = 2
	monster_body.monitoring = true
	monster_body.monitorable = true
	monster_body.area_entered.connect(get_hit)

func get_hit(proj: Area2D):
	if(proj.is_in_group("projectile") && proj.target == monster_body || proj.target == null):
		take_damage(proj.damage)
		proj.queue_free()

func _physics_process(delta: float) -> void:
	progress_ratio += delta / (LOOP_SECONDS / speed)
	
	if progress_ratio >= 1.0:
		escape()

func init(config: MonsterConfig):
	escape_cost = config.escape_cost
	speed = config.speed
	health = config.health
	frames = config.sprite

func take_damage(damage: int):
	health -= damage
	if(health <= 0):
		print("killed")
		monster_killed.emit(self)
		queue_free()

func escape():
	print("escaped")
	monster_escape.emit(self)
	queue_free()
	
