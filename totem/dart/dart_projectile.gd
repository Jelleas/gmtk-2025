extends Area2D

@export var speed := 3000.0
var direction := Vector2.ZERO
var target: Area2D
var damage: int

func _ready():
	monitoring = true
	monitorable = true
	collision_layer = 1
	collision_mask = 1
	add_to_group("projectile")
	self.area_entered.connect(_on_projectile_hit)

func _on_projectile_hit(body: Area2D):
	if(body.is_in_group("monster")):
		queue_free()

func _physics_process(delta):
	position += direction * speed * delta
