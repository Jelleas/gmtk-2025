extends VBoxContainer

@export var resource_path: Path2D;

const resource_counter_scene: PackedScene = preload("res://ui/resource_tracker/resource_counter.tscn")

var counters: Array[ResourceCounter] = []

func _ready() -> void:
	$ResourceBar.init(resource_path)
	
	for res in Res.Type.values():
		add_counter(res)

func _process(_delta: float) -> void:
	update_counts()

func add_counter(res: Res.Type) -> void:
	var counter = resource_counter_scene.instantiate()
	counter.init(res)
	$GridContainer.add_child(counter)
	counters.append(counter)

func update_counts():
	var count_map = create_count_map()
	for counter in counters:
		if counter.resource in count_map:
			counter.update_count(count_map[counter.resource])

func create_count_map() -> Dictionary[Res.Type, int]:
	var count_map: Dictionary[Res.Type, int] = {}
	
	var count = 0
	for c in resource_path.contents:
		if c != null:
			if c.type in count_map:
				count_map[c.type] += 1
			else:
				count_map[c.type] = 1
	
	return count_map
