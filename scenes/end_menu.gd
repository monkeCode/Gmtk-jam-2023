extends Control

var scene_to_load = load("res://scenes/mainScene.tscn")

@onready var label = $Label

func _ready():
	if !StaticValues.is_game_win:
		label.text = "YOU  LOSE"
	else:
		label.text = "YOU  WON"

func _on_button_pressed():
	get_tree().change_scene_to_packed(scene_to_load)
