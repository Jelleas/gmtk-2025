extends PathFollow2D

class_name Monster

signal monster_escape(monster: Monster)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const LOOP_SECONDS = 100

var escape_cost: int
var speed: int
var health: int
var frames: SpriteFrames

func _ready() -> void:
	sprite.sprite_frames = frames
	sprite.play("default")

func _process(delta: float) -> void:
	progress_ratio += delta / (LOOP_SECONDS / speed)
	
	if progress_ratio >= 1.0:
		escape()

func init(config: MonsterConfig):
	escape_cost = config.escape_cost
	speed = config.speed
	health = config.health
	frames = config.sprite

func escape():
	print("escaped")
	monster_escape.emit(self)
	queue_free()
	
