extends Node2D

class_name TotemInterface

@export var resource_manager: Path2D
@export var totem_scene: PackedScene

signal TotemSelected(totem: Totem)
signal TotemUnselected(totem: Totem)

var plots: Array = []

func totem_pressed(plot_index: int):
	var fill_plot = plots[plot_index]
	var totem
	if(!plots[plot_index].size() > 3):
		totem = create_totem(plot_index, fill_plot)
		plots[plot_index][3] = totem
	else:
		totem = plots[plot_index][3]
	print(totem)
	
	TotemSelected.emit(totem)

func create_totem(totem_index: int, fill_plot) -> Totem:
	var totem_scene = totem_scene.instantiate()
	add_child(totem_scene)
	totem_scene.init(resource_manager, fill_plot[0], fill_plot[1])
	plots[totem_index].append(totem_scene)
	
	match totem_index:
		0:
			totem_scene.set_base(TotemPieces.base_types[0])
			fill_plot[2].text = TotemPieces.base_types[0].name
		1:
			totem_scene.set_base(TotemPieces.base_types[0])
			fill_plot[2].text = TotemPieces.base_types[0].name
		2:
			totem_scene.set_base(TotemPieces.base_types[1])
			fill_plot[2].text = TotemPieces.base_types[0].name
		3:
			totem_scene.set_base(TotemPieces.base_types[1])
			fill_plot[2].text = TotemPieces.base_types[0].name
		_:
			totem_scene.set_base(TotemPieces.Dart.new())
			fill_plot[2].text = "Dart"
	return totem_scene

func set_base(totem_index: int, base: TotemPieces.TotemBase):
	plots[totem_index].set_base(base)

func add_modifier(totem_index: int, modifier: TotemPieces.Modifier):
	plots[totem_index].add_modifier(modifier)

func enable_plot(totem_index: int):
	plots[totem_index][2].show()

func _ready() -> void:
	plots = [
		[51, 52, $TotemPlot],
		[47, 48, $TotemPlot1],
		[43, 44, $TotemPlot2],
		[39, 40, $TotemPlot3],
		[0, 1, $TotemPlot4],
		[3, 4, $TotemPlot5],
		[9, 10, $TotemPlot6],
		[15, 16, $TotemPlot7],
		[18, 19, $TotemPlot8],
		[21, 22, $TotemPlot9],
		[27, 28, $TotemPlot10],
		[33, 34, $TotemPlot11],
		[36, 37, $TotemPlot12],
		[39, 40, $TotemPlot13],
		[45, 46, $TotemPlot14],
		[51, 52, $TotemPlot15],
		[54, 55, $TotemPlot16],
		[57, 58, $TotemPlot17],
		[63, 64, $TotemPlot18],
		[69, 70, $TotemPlot19],
	]
	init_buttons()
	hide_buttons()

func init_buttons():
	for i in range(0, plots.size()):
		plots[i][2].pressed.connect(func() -> void: totem_pressed(i))

func hide_buttons():
	for i in range(0, plots.size()):
		if i == 0 || i == 1 || i == 4  || i == 5:
			continue
		#totems[i][3].hide()
