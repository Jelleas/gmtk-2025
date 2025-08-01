extends VBoxContainer

class_name InventorySlot

signal ItemDeleted(item: TotemPieces.TotemPiece)

var content: TotemPieces.TotemPiece

func _ready() -> void:
	style_button()
	empty()
	$Control/DeleteButton.button_up.connect(_on_delete_button_pressed)

func _on_delete_button_pressed():
	ItemDeleted.emit(content)

func style_button() -> void:
	var delete_button = $Control/DeleteButton
	
	delete_button.size = Vector2(35, 35)
	delete_button.position = Vector2(62, -25)

	# Create the StyleBoxes
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.8, 0, 0)  # red
	normal_style.set_corner_radius_all(5)
	
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(1, 0.2, 0.2)  # lighter red
	hover_style.set_corner_radius_all(5)

	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = Color(0.6, 0, 0)  # darker red
	pressed_style.set_corner_radius_all(5)
	
	# Apply StyleBoxes via theme overrides
	delete_button.set("theme_override_styles/normal", normal_style)
	delete_button.set("theme_override_styles/hover", hover_style)
	delete_button.set("theme_override_styles/pressed", pressed_style)

func show_delete() -> void:
	$Control/DeleteButton.self_modulate.a = 1.0

func is_empty() -> bool:
	return content == null
	
func empty() -> void:
	content = null
	$Label.self_modulate.a = 0.0
	$Control/DeleteButton.self_modulate.a = 0.0
	$HBoxContainer/TextureRect.self_modulate.a = 0.0
	
func fill(content_: TotemPieces.TotemPiece) -> void: # TODO type hint
	content = content_

	$Label.self_modulate.a = 1.0
	$Label.text = content.name
	
	$HBoxContainer/TextureRect.self_modulate.a = 1.0
	
	tooltip_text = content.description
	$Control/DeleteButton.tooltip_text = content.description
