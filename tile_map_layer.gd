extends TileMapLayer

signal tile_clicked(cell_coords: Vector2i, tile_id: int)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var screen_pos: Vector2 = event.position
		var world_pos = get_viewport().get_canvas_transform().affine_inverse() * screen_pos
		var cell_coords = local_to_map(to_local(world_pos))

		var tile_id = get_cell_source_id(cell_coords)

		if tile_id != -1:
			emit_signal("tile_clicked", cell_coords, tile_id)
		else:
			print("❌ No tile at:", cell_coords)
