extends Dude
class_name Rogue

var bomb = preload("res://scenes/dudes/Bomb.tscn")
@export var bombs_count:int = 4

func release_ability_1(target):
	var start_angle = randf_range(0, 2*PI)
	var b = bomb.instantiate()
	b.position = position
	

func release_ability_2(target):
	
