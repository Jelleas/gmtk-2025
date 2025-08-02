extends MarginContainer

@export var resource_line: PackedScene # ResourceLine

var resources: Dictionary[Res.Type, int]

func set_resources(resources_: Dictionary[Res.Type, int]):
	resources = resources_
	
	for child in $GridContainer.get_children():
		child.free()
	
	for prod in resources:
		var quant = resources[prod]
		
		var line = resource_line.instantiate()
		
		line.set_resource(prod, quant)
		$GridContainer.add_child(line)
