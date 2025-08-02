extends Area2D

@export var grav := 1400.0
@export var initial_vertical_speed := -300.0

@onready var sprite = $Sprite2D

var vertical_velocity := 0.0
var z_height := 0.0
var radius := 200

var target: Area2D = null
var damage: int

func _ready():
	vertical_velocity = initial_vertical_speed
	$CollisionShape2D.disabled = true
	$CollisionShape2D.shape.radius = radius
	monitoring = true
	monitorable = true
	collision_layer = 2
	collision_mask = 1
	add_to_group("projectile")

func _physics_process(delta):
	# Apply gravity
	vertical_velocity += grav * delta
	z_height += vertical_velocity * delta

	# Simulate drop by adjusting sprite position upward
	sprite.position.y = z_height

	# When it "lands"
	if z_height > 0:
		sprite.position.y = 0
		$CollisionShape2D.disabled = false
		queue_free()  # or play impact animation
