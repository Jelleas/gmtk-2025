extends PanelContainer

@export var monster_manager: MonsterPath
@export var shop: Shop

var wave: int = 0
var unlocks: Array[TotemPieces.TotemPiece] = []

var wave_label: Label
var unlock_grid: GridContainer

var to_show_unlocks: Array[TotemPieces.TotemPiece] = []

var is_toast_on_screen = false

func _ready() -> void:
	self.visible = false
	monster_manager.wave_started.connect(_on_wave_started)
	shop.totem_piece_unlocked.connect(_on_totem_piece_unlocked)
	
	wave_label = $MarginContainer/VBoxContainer/Label
	unlock_grid = $MarginContainer/VBoxContainer/GridContainer
	
func _process(_delta: float):
	if is_toast_on_screen and to_show_unlocks.size() > 0:
		to_show_unlocks.map(add_unlock_to_active_toast)
		to_show_unlocks = []
	
func _on_wave_started(wave_number: int, next_wave_in: float) -> void:
	wave = wave_number
	toast()
	
func _on_totem_piece_unlocked(totem_piece: TotemPieces.TotemPiece) -> void:
	to_show_unlocks.append(totem_piece)

func toast() -> void:
	wave_label.text = "Wave " + str(wave) + " started"
	clear_unlock_grid()
	pop_on_screen()
	
func add_unlock_to_active_toast(unlock: TotemPieces.TotemPiece) -> void:
	var label = Label.new()
	label.text = unlock.name + " unlocked in shop" 
	
	var rect = TextureRect.new()
	rect.texture = get_unlock_image(unlock.icon)
	
	unlock_grid.add_child(rect)
	unlock_grid.add_child(label)
	
func get_unlock_image(res: Resource) -> ImageTexture:
	var image = res.get_image()
	image.resize(68, 48, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)
	
func clear_unlock_grid() -> void:
	for child in unlock_grid.get_children():
		child.free()
	
func pop_on_screen():
	is_toast_on_screen = true

	self.visible = true
	self.scale = Vector2(0.5, 0.5)
	self.modulate.a = 0.0

	var size = self.size
	self.pivot_offset = size / 2

	# splash in
	var tween = create_tween()
	tween.tween_property(
		self, 
		"scale", 
		Vector2(1.0, 1.0),
		0.5
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

	# wait 3 seconds
	await get_tree().create_timer(3.0).timeout
	
	# not enough time for any further unlocks to show
	is_toast_on_screen = false 
	
	# wait 2 seconds
	await get_tree().create_timer(2.0).timeout
	
	# then fade out
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0).set_trans(Tween.TRANS_BACK)
	await tween.finished

	self.visible = false
