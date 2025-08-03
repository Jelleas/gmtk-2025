extends PanelContainer

@export var monster_manager: MonsterPath

var wave = 0
var unlocks = []
var tween

func _ready() -> void:
	tween = create_tween()
	self.visible = false
	monster_manager.wave_started.connect(_on_wave_started)
	toast()
	
func _on_wave_started(wave_number: int, next_wave_in: float) -> void:
	wave = wave_number
	# TODO unlocks
	toast()

func toast() -> void:
	var panel = $MarginContainer/VBoxContainer/Label
	panel.text = "Wave " + str(wave) + " started"
	
	pop_on_screen()
	
func pop_on_screen():
	self.visible = true
	self.scale = Vector2(0.5, 0.5)
	self.modulate.a = 0.0 # transparent

	var size = self.size
	self.pivot_offset = size / 2

	# splash in
	tween = create_tween()
	tween.tween_property(
		self, 
		"scale", 
		Vector2(1.0, 1.0),
		0.5
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

	# wait 5 seconds
	await get_tree().create_timer(5.0).timeout
	
	# then fade out
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0).set_trans(Tween.TRANS_BACK)
	await tween.finished

	self.visible = false
