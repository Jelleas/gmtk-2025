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

func _on_button_up() -> void:
	if item != null:
		item_bought.emit(item)

func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = for_text
	return label
