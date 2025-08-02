extends VBoxContainer

class_name InventorySlot

signal ItemDeleted(item: TotemPieces.TotemPiece)

var totem_piece: TotemPieces.TotemPiece

func _ready() -> void:
	style_button()
	empty()
	$Control/DeleteButton.button_up.connect(_on_delete_button_pressed)
	$Control/DeleteButton.disabled = true

func _on_delete_button_pressed():
	hide_delete()
	ItemDeleted.emit(totem_piece)
	
func show_delete() -> void:
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
	
	$HBoxContainer/TextureRect.self_modulate.a = 1.0
	
	tooltip_text = totem_piece.description
	$Control/DeleteButton.tooltip_text = totem_piece.description

func style_button() -> void:
	var delete_button = $Control/DeleteButton
	
	delete_button.size = Vector2(35, 35)
	delete_button.position = Vector2(62, -25)

	# Create the StyleBoxes
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.8, 0, 0)
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
