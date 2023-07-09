extends Node2D

var scene_to_load = load("res://scenes/end_menu.tscn")

func _on_player_died():
	get_tree().change_scene_to_packed(scene_to_load)
