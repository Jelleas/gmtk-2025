extends CheckButton

@export var audio_player: AudioStreamPlayer

func _ready() -> void:
	button_pressed = true
	self.button_up.connect(_on_button_up)
	
func _on_button_up() -> void:
	if button_pressed:
		audio_player.play()
	else:
		audio_player.stop()
