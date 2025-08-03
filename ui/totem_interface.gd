extends Node2D

class_name TotemInterface

@export var resource_manager: Path2D
@export var totem_scene: PackedScene
@export var tile_map: TileMapLayer
@export var empty_plot: PackedScene
@export var bones_tracker: BonesTracker
@export var monster_path: MonsterPath
@export var lock_image: Texture2D

signal TotemSelected(totem: Totem)
signal TotemUnselected(totem: Totem)

var plots: Array = []
var price: int = 5
var current_wave: int = 0

var selected_totem: Totem

var lock_sprites: Array[Sprite2D] = [null, null, null, null]

func totem_pressed(plot_index: int):
	var fill_plot = plots[plot_index]
	var totem
	if(!plots[plot_index][2] is Totem):
		var empty_plot = plots[plot_index][2]
		var is_locked_producer = plot_index < 4 and current_wave < plot_index
		if is_locked_producer or !bones_tracker.spend(price):
			empty_plot.modulate = Color.RED
			var tween = create_tween()
			tween.tween_property(empty_plot, "modulate", Color(Color.WHITE, 0.5), 0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
			return
		empty_plot.destroy()
		totem = create_totem(plot_index, fill_plot)
		plots[plot_index][2] = totem
		price = min(price * 2, 300)
		update_plot_price()
	else:
		totem = plots[plot_index][2]
	
	# unselect previous totem and select new
	if selected_totem != null:
		selected_totem.unselect()
	selected_totem = totem
	totem.select()
	
	TotemSelected.emit(totem)
	
func create_totem(totem_index: int, fill_plot) -> Totem:
	var totem_scene: Totem = totem_scene.instantiate()
	add_child(totem_scene)
	totem_scene.init(resource_manager, fill_plot[0][0], fill_plot[0][1], tile_map, fill_plot[1])
	plots[totem_index][2] = totem_scene
	
	if(totem_index < 4):
		set_producer(totem_index, totem_scene)
	
	return totem_scene

func set_producer(totem_index: int, totem_scene: Totem) -> void:
	match totem_index:
		0:
			totem_scene.set_base(TotemPieces.Forest.new())
		1:
			totem_scene.set_base(TotemPieces.Pond.new())
		2:
			totem_scene.set_base(TotemPieces.MossValley.new())
		3:
			totem_scene.set_base(TotemPieces.Shrubbery.new())

func set_base(totem_index: int, base: TotemPieces.TotemBase):
	plots[totem_index].set_base(base)

func add_modifier(totem_index: int, modifier: TotemPieces.Modifier):
	plots[totem_index].add_modifier(modifier)

func update_plot_price():
	for i in range(0, plots.size()):
		if(!plots[i][2] is Totem):
			plots[i][2].set_price(price)

func add_empty_plot(plot_index: int, plot_pos: Vector2i):
	var tile_size = tile_map.tile_set.tile_size
	var local_pos = tile_map.map_to_local(plot_pos)
	var global_pos = tile_map.to_global(local_pos)
	
	
	var sprite = empty_plot.instantiate()

	match plot_index:
		0:
			sprite.texture = TotemPieces.Forest.new().icon
		1:
			sprite.texture = TotemPieces.Pond.new().icon
			_add_lock(plot_index, sprite)
		2:
			sprite.texture = TotemPieces.MossValley.new().icon
			_add_lock(plot_index, sprite)
		3:
			sprite.texture = TotemPieces.Shrubbery.new().icon
			_add_lock(plot_index, sprite)
		_: 
			sprite.set_color(Color.html("#ffffff"))
	
	sprite.modulate = Color(Color.WHITE, 0.5)
	sprite.global_position = local_pos
	sprite.set_price(price)
	add_child(sprite)
	
	return sprite

func _add_lock(index: int, sprite: Sprite2D):
	print("add lock")
	var lock_sprite = Sprite2D.new()
	lock_sprites[index] = lock_sprite
	lock_sprite.texture = lock_image
	sprite.add_child(lock_sprite)
	lock_sprite.position = Vector2.ZERO

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
	monster_path.wave_started.connect(_on_wave_started)
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
	
	for i in range(0, plots.size()):
		var empty_plot = add_empty_plot(i, plots[i][1])
		plots[i].append(empty_plot)
	
	# get forest for free
	create_totem(0, plots[0])
		
func _on_wave_started(wave_number: int, _n: float):
	if wave_number > 0 and wave_number < 4: lock_sprites[wave_number].queue_free()
	current_wave = wave_number
