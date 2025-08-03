extends Node2D

func _ready() -> void:
	$StartGame.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main_level.tscn")
