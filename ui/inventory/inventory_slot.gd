extends VBoxContainer

class_name InventorySlot

var content # TODO type hint

func _ready() -> void:
	$Label.self_modulate.a = 0.0
	$Button.self_modulate.a = 0.0

func is_empty() -> bool:
	return content == null
	
func load(content_) -> void: # TODO type hint
	content = content_

	$Label.self_modulate.a = 1.0
	$Label.text = content
	$Button.self_modulate.a = 1.0
