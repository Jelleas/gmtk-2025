extends Camera2D

@export var move_speed := 300.0

func _process(delta):
	var input_vector := Vector2(
		Input.get_action_strength("camera_move_right") - Input.get_action_strength("camera_move_left"),
		Input.get_action_strength("camera_move_down") - Input.get_action_strength("camera_move_up")
	)

	# Normalize to prevent faster diagonal movement
	if input_vector.length_squared() > 1.0:
		input_vector = input_vector.normalized()

	position += input_vector * move_speed * delta
