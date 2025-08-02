extends Camera2D

@export var move_speed := 300.0
@export var mouse_zoom_speed := 0.1
@export var min_zoom_value := 0.5
@export var max_zoom_value := 3

func _process(delta):
	var input_vector := Vector2(
		Input.get_action_strength("camera_move_right") - Input.get_action_strength("camera_move_left"),
		Input.get_action_strength("camera_move_down") - Input.get_action_strength("camera_move_up")
	)
	
	var zoom_value := Input.get_action_strength("camera_zoom_in") - Input.get_action_strength("camera_zoom_out")
	
	
	# Normalize to prevent faster diagonal movement
	if input_vector.length_squared() > 1.0:
		input_vector = input_vector.normalized()

	position += input_vector * move_speed * delta
	_zoom(zoom_value * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_zoom(mouse_zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_zoom(-mouse_zoom_speed)

func _zoom(value: float):
	var zoomFactor = clampf(zoom.x + value, min_zoom_value, max_zoom_value)
	zoom = Vector2(zoomFactor, zoomFactor)
