extends Node2D

class_name TotemInterface

@export var resource_manager: Path2D
@export var totem_scene: PackedScene
@export var tile_map: TileMapLayer

signal TotemSelected(totem: Totem)
signal TotemUnselected(totem: Totem)

var plots: Array = []

func totem_pressed(plot_index: int):
	var fill_plot = plots[plot_index]
	var totem
	if(!plots[plot_index].size() > 2):
		totem = create_totem(plot_index, fill_plot)
		plots[plot_index][2] = totem
	else:
		totem = plots[plot_index][2]
	
	TotemSelected.emit(totem)

func create_totem(totem_index: int, fill_plot) -> Totem:
	var totem_scene = totem_scene.instantiate()
	add_child(totem_scene)
	totem_scene.init(resource_manager, fill_plot[0][0], fill_plot[0][1], tile_map, fill_plot[1])
	plots[totem_index].append(totem_scene)
	
	match totem_index:
		0:
			totem_scene.set_base(TotemPieces.base_types[0])
		1:
			totem_scene.set_base(TotemPieces.base_types[0])
		2:
			totem_scene.set_base(TotemPieces.base_types[1])
		3:
			totem_scene.set_base(TotemPieces.base_types[1])
		4:
			totem_scene.set_base(TotemPieces.FrogBomb.new())
		5:
			totem_scene.set_base(TotemPieces.Dart.new())
	return totem_scene

func set_base(totem_index: int, base: TotemPieces.TotemBase):
	plots[totem_index].set_base(base)

func add_modifier(totem_index: int, modifier: TotemPieces.Modifier):
	plots[totem_index].add_modifier(modifier)

#func enable_plot(totem_index: int):
	#plots[totem_index][2].show()

var adjacent_offsets: Array[Vector2i] = [
	Vector2i(0, 0),
	Vector2i(-1, -1),
	Vector2i(0, -1),
	Vector2i(1, -1),
	Vector2i(-1, 0),
	Vector2i(1, 0),
	Vector2i(-1, 1),
	Vector2i(0,  1),
	Vector2i(1,  1),
]

func _on_tile_clicked(cell_coords: Vector2i, tile_id: int) -> void:
	for i in range(0, plots.size()):
		var plot_coords: Vector2i = plots[i][1]
		for offset in adjacent_offsets:
			if cell_coords + offset == plot_coords:
				totem_pressed(i)
				break

func _ready() -> void:
	tile_map.tile_clicked.connect(_on_tile_clicked)
	plots = [
		[[51, 52], Vector2i(10, 21)],
		[[47, 48], Vector2i(14, 21)],
		[[43, 44], Vector2i(18, 21)],
		[[39, 40], Vector2i(22, 21)],
		[[0, 1], Vector2i(4, 3)],
		[[3, 4], Vector2i(10, 3)],
		[[9, 10], Vector2i(16, 3)],
		[[15, 16], Vector2i(22, 3)],
		[[18, 19], Vector2i(28, 3)],
		[[21, 22], Vector2i(28, 9)],
		[[27, 28], Vector2i(28, 15)],
		[[33, 34], Vector2i(28, 21)],
		[[36, 37], Vector2i(28, 27)],
		[[39, 40], Vector2i(22, 27)],
		[[45, 46], Vector2i(16, 27)],
		[[51, 52], Vector2i(10, 27)],
		[[54, 55], Vector2i(4, 27)],
		[[57, 58], Vector2i(4, 21)],
		[[63, 64], Vector2i(4, 15)],
		[[69, 70], Vector2i(4, 9)],
	]
