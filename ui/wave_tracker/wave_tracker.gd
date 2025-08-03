extends VBoxContainer

@export var monster_manager: MonsterPath

var wave: int
var next_wave_in: float
var tween

func _ready():
	monster_manager.wave_started.connect(_on_wave_started)
	wave = 0
	next_wave_in = -1
	set_wave()
	
func _on_wave_started(wave_number: int, next_wave_in_: float) -> void:
	wave = wave_number
	next_wave_in = next_wave_in_
	set_wave()
	
func set_wave() -> void:
	if tween != null:
		tween.stop()
	
	menu_vars.wave_reached = wave
	
	$WaveBar.value = 0.0
	$WaveBar.max_value = next_wave_in
	$Label.text = "Wave " + str(wave)
	
	if next_wave_in < 0:
		return
	
	tween = create_tween()
	tween.tween_property(
		$WaveBar, 
		"value", 
		$WaveBar.value + $WaveBar.max_value, next_wave_in
	).set_trans(Tween.TRANS_LINEAR)
