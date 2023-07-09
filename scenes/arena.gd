extends Node2D

var scene_to_load = load("res://scenes/end_menu.tscn")
var entities = 3

func _on_player_died():
	StaticValues.is_game_win = false
	get_tree().change_scene_to_packed(scene_to_load)

func _on_rogue_died():
	entity_died()

func _on_druid_died():
	entity_died()

func _on_sword_man_died():
	entity_died()
	
	
func entity_died():
	entities-=1
	if entities == 0:
		StaticValues.is_game_win = true
		get_tree().change_scene_to_packed(scene_to_load)
