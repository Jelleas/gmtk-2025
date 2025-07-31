extends VBoxContainer

class_name ShopItem

signal item_bought(item) # TODO type hint

var item # TODO type hint

func _ready() -> void:
	$Button.button_up.connect(_on_button_up)

func init(item_) -> void: # TODO type hint
	item = item_
	$Label.text = item

func _on_button_up() -> void:
	if item != null:
		item_bought.emit(item)
