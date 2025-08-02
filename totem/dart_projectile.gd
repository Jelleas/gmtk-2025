extends Area2D

@export var speed := 400.0
var direction := Vector2.ZERO
var target: Area2D
var damage: int

func _ready():
	monitoring = true
	monitorable = true
	collision_layer = 2
	collision_mask = 1
	add_to_group("projectile")

func _physics_process(delta):
	position += direction * speed * delta
