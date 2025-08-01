extends VBoxContainer

class_name InventorySlot

var content: TotemPieces.TotemPiece

func _ready() -> void:
	empty()

func is_empty() -> bool:
	return content == null
	
func empty() -> void:
	content = null
	$Label.self_modulate.a = 0.0
	$Button.self_modulate.a = 0.0
	
func fill(content_: TotemPieces.TotemPiece) -> void: # TODO type hint
	content = content_

	$Label.self_modulate.a = 1.0
	$Label.text = content.name
	$Button.self_modulate.a = 1.0

	tooltip_text = content.description
	$Button.tooltip_text = content.description
