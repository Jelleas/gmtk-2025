extends Node2D

@export var resource_manager: Path2D
@export var totem_scene: PackedScene


var totems = []

func totem_pressed(totem_index):
	if(totems[totem_index].size() < 5):
		var totem = totems[totem_index]
		var totem_instance = create_totem(totem[0], totem[1], totem[2])
		totems[totem_index].append(totem_instance)
		
		if(totem_index <4):
			totem[3].text ="P"
		else:
			totem[3].text ="C"

func create_totem(resource, start, end):
	var totem = totem_scene.instantiate()
	add_child(totem)
	totem.init(resource_manager, resource, start, end)

func set_base(totem_index, base_type):
	totems[totem_index].set_base()

func upgrade_totem(totem_index):
	totems[totem_index].upgrade()

func enable_plot(totem_index):
	totems[totem_index][3].show()

func _ready() -> void:
	totems = [
		[Res.Type.WOOD, 51, 52, $TotemPlot],
		[Res.Type.WOOD, 47, 48, $TotemPlot1],
		[Res.Type.FROG, 43, 44, $TotemPlot2],
		[Res.Type.FROG, 39, 40, $TotemPlot3],
		[-1, 0, 1, $TotemPlot4],
		[-1, 3, 4, $TotemPlot5],
		[-1, 9, 10, $TotemPlot6],
		[-1, 15, 16, $TotemPlot7],
		[-1, 18, 19, $TotemPlot8],
		[-1, 21, 22, $TotemPlot9],
		[-1, 27, 28, $TotemPlot10],
		[-1, 33, 34, $TotemPlot11],
		[-1, 36, 37, $TotemPlot12],
		[-1, 39, 40, $TotemPlot13],
		[-1, 45, 46, $TotemPlot14],
		[-1, 51, 52, $TotemPlot15],
		[-1, 54, 55, $TotemPlot16],
		[-1, 57, 58, $TotemPlot17],
		[-1, 63, 64, $TotemPlot18],
		[-1, 69, 70, $TotemPlot19],
	]
	init_buttons()
	hide_buttons()

func init_buttons():
	for i in range(0, totems.size()):
		totems[i][3].pressed.connect(func() -> void: totem_pressed(i))

func hide_buttons():
	for i in range(0, totems.size()):
		if i == 1 || i == 2 || i == 4  || i == 5:
			print(i)
			continue
		totems[i][3].hide()
