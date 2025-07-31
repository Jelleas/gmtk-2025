extends VBoxContainer

class_name ShopItem

signal item_bought(item) # TODO type hint

var item # TODO type hint

func _ready() -> void:
	$Button.custom_minimum_size = Vector2(100, 50)

func init(item_) -> void: # TODO type hint
	item = item_
	$GridContainer/NameLabel.text = item
	$GridContainer/PriceLabel.text = "100$"

func _on_button_up() -> void:
	if item != null:
		item_bought.emit(item)
