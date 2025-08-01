extends VBoxContainer

class_name ShopItem

signal item_bought(modifier: TotemPieces.TotemPiece)

var item: TotemPieces.TotemPiece

func _ready() -> void:
	$Button.custom_minimum_size = Vector2(100, 50)
	$Button.button_up.connect(_on_button_up)

func init(item_: TotemPieces.TotemPiece) -> void:
	item = item_
	tooltip_text = item.description
	$Button.tooltip_text = item.description
	$HBoxContainer/NameLabel.text = item.name
	$HBoxContainer/PriceLabel.text = str(item.price) + '$'

func enable() -> void:
	$HBoxContainer/NameLabel.self_modulate.a = 1.0
	$HBoxContainer/PriceLabel.self_modulate.a = 1.0
	$Button.disabled = false
	
func disable() -> void:
	$HBoxContainer/NameLabel.self_modulate.a = 0.5
	$HBoxContainer/PriceLabel.self_modulate.a = 0.5
	$Button.disabled = true

func _on_button_up() -> void:
	if item != null:
		item_bought.emit(item)

func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = for_text
	return label
