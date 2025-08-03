extends Camera2D

@export var move_speed := 750.0
@export var mouse_zoom_speed := 0.1
@export var min_zoom_value := 0.2
@export var max_zoom_value := 3
@export var grid_top_left := Vector2i(0, 0)
@export var grid_bottom_right := Vector2i(30, 30)
@export var grid: TileMapLayer

var min_pos: Vector2
var max_pos: Vector2

func _ready() -> void:
	min_pos = grid.to_global(grid.map_to_local(grid_top_left))
	max_pos = grid.to_global(grid.map_to_local(grid_bottom_right))
	global_position = grid.to_global(grid.map_to_local((grid_bottom_right - grid_top_left)/2))
	zoom = Vector2(min_zoom_value, min_zoom_value)

func _process(delta):
	var input_vector := Vector2(
		Input.get_action_strength("camera_move_right") - Input.get_action_strength("camera_move_left"),
		Input.get_action_strength("camera_move_down") - Input.get_action_strength("camera_move_up")
	)
	
	var zoom_value := Input.get_action_strength("camera_zoom_in") - Input.get_action_strength("camera_zoom_out")
	
	# Normalize to prevent faster diagonal movement
	if input_vector.length_squared() > 1.0:
		input_vector = input_vector.normalized()
		
	var pos_offset = input_vector * move_speed * delta * (1/zoom.x)
	var new_pos_x = clampf(global_position.x + pos_offset.x, min_pos.x, max_pos.x)
	var new_pos_y = clampf(global_position.y + pos_offset.y, min_pos.y, max_pos.y)
	global_position = Vector2(new_pos_x, new_pos_y)
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
