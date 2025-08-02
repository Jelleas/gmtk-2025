extends Area2D

signal target_detected(target)

@export var detection_radius := 32.0

func _ready():
	$CollisionShape2D.shape.radius = detection_radius
	monitoring = true
	monitorable = true
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("target_detected", body)
