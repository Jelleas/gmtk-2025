extends VBoxContainer

@export var resource_path: Path2D;

const resource_counter_scene: PackedScene = preload("res://ui/resource_tracker/resource_counter.tscn")

var counters: Array[ResourceCounter] = []

func _ready() -> void:
	$ResourceBar.init(resource_path)
	
	for res in Res.Type.values():
		add_counter(res)

func add_counter(res: Res.Type) -> void:
	var counter = resource_counter_scene.instantiate()
	counter.init(resource_path, res)
	$GridContainer.add_child(counter)
	counters.append(counter)
