extends Node2D

@export var resource_manager: Path2D
@export var totem_scene: PackedScene


var totems: Array = []

func totem_pressed(totem_index: int):
	var totem = totems[totem_index]
	if(totems[totem_index].size() < 5):
		create_totem(totem_index, totem)
	#elif(totem[4].base == 0):
		#totem[4].set_base(TotemPieces.BaseType.DART)
	else:
		totem[4].add_modifier(TotemPieces.Speed1.new())
	

func create_totem(totem_index: int, totem):
	var totem_scene = totem_scene.instantiate()
	add_child(totem_scene)
	totem_scene.init(resource_manager, totem[1], totem[2])
	totems[totem_index].append(totem_scene)
	
	if(totem_index <4):
		totem_scene.set_base(totem[0])
		totem[3].text = totem[0].name
	else:
		totem[3].text ="C"

func set_base(totem_index: int, base: TotemPieces.Base):
	totems[totem_index].set_base(base)

func add_modifier(totem_index: int, modifier: TotemPieces.Modifier):
	totems[totem_index].add_modifier(modifier)

func enable_plot(totem_index: int):
	totems[totem_index][3].show()

func _ready() -> void:
	totems = [
		[TotemPieces.Forest.new(), 51, 52, $TotemPlot],
		[TotemPieces.Forest.new(), 47, 48, $TotemPlot1],
		[TotemPieces.Pond.new(), 43, 44, $TotemPlot2],
		[TotemPieces.Pond.new(), 39, 40, $TotemPlot3],
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
		if i == 0 || i == 1 || i == 4  || i == 5:
			continue
		#totems[i][3].hide()
