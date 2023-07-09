extends Node2D

@export var scene_to_load : PackedScene

func _on_player_died():
	get_tree().change_scene_to_packed(scene_to_load)
