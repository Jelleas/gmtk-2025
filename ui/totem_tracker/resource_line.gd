extends HBoxContainer

class_name ResourceLine

var resource: Res.Type
var quantity: int

func set_resource(resource_: Res.Type, quantity_: int) -> void:
	resource = resource_
	quantity = quantity_
	
	$Label.text = str(quantity) + " " + Res.Type.keys()[resource].capitalize()
