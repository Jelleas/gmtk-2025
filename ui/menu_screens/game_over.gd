extends Node2D

@export var health_tracker: TextureProgressBar

func _ready():
	$BackToMenu.pressed.connect(_on_back_to_menu_pressed)
	$ScoreLabel.text = "Reached Wave: %s" % str(menu_vars.wave_reached)

func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://ui/menu_screens/main_menu.tscn")
