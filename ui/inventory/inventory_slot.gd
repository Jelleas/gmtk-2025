extends VBoxContainer

class_name InventorySlot

signal ItemDeleted(item: TotemPieces.TotemPiece)

var totem_piece: TotemPieces.TotemPiece

func _ready() -> void:
	style_delete_button()
	style_background()
	empty()
	$Control/DeleteButton.button_up.connect(_on_delete_button_pressed)
	$Control/DeleteButton.disabled = true

func _on_delete_button_pressed():
	hide_delete()
	ItemDeleted.emit(totem_piece)

func refresh():
	style_background()

func show_delete() -> void:
	if totem_piece.type == TotemPieces.BaseType.PRODUCER:
		return
	
	$Control/DeleteButton.self_modulate.a = 1.0
	$Control/DeleteButton.disabled = false

func hide_delete() -> void:
	$Control/DeleteButton.self_modulate.a = 0.0
	$Control/DeleteButton.disabled = true

func is_empty() -> bool:
	return totem_piece == null
	
func empty() -> void:
	totem_piece = null
	$Label.self_modulate.a = 0.0
	$Control/DeleteButton.self_modulate.a = 0.0
	$HBoxContainer/TextureRect.self_modulate.a = 0.0
	
func fill(content_: TotemPieces.TotemPiece) -> void:
	totem_piece = content_

	$Label.self_modulate.a = 1.0
	$Label.text = totem_piece.name
	$HBoxContainer/TextureRect.texture = content_.icon
	
	$HBoxContainer/TextureRect.self_modulate.a = 1.0
	
	tooltip_text = totem_piece.description
	$Control/DeleteButton.tooltip_text = totem_piece.description
	
	style_background()

func style_background() -> void:
	var rarity = null if totem_piece == null else totem_piece.rarity
	
	var panel = $MarginContainer/Panel
	
	var original_style = panel.get_theme_stylebox("panel") as StyleBoxFlat
	var instance_style = original_style.duplicate() as StyleBoxFlat
	
	instance_style.set_border_width_all(3)
	instance_style.border_color = ShopItem.RARITY_COLOR_MAP[rarity]
	
	panel.add_theme_stylebox_override("panel", instance_style)

func style_delete_button() -> void:
	var delete_button = $Control/DeleteButton
	
	delete_button.icon = get_image(load("res://assets/trash-can-icon-28675.png"))
	
	delete_button.size = Vector2(24, 24)
	delete_button.position = Vector2(72, -10)

	# Create the StyleBoxes
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.7, 0, 0)
	normal_style.set_corner_radius_all(5)
	
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(1, 0.2, 0.2)
	hover_style.set_corner_radius_all(5)

	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = Color(0.6, 0, 0)
	pressed_style.set_corner_radius_all(5)
	
	# Apply StyleBoxes via theme overrides
	delete_button.set("theme_override_styles/normal", normal_style)
	delete_button.set("theme_override_styles/hover", hover_style)
	delete_button.set("theme_override_styles/pressed", pressed_style)

func get_image(resource: Resource) -> ImageTexture:
	var image = resource.get_image()
	image.resize(24, 24, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)
