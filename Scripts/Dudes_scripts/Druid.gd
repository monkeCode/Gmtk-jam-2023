class_name Druid
extends Dude

var root = null

func ability_1_custom_condition():
	var vec = target.position - position
	return vec.length() > atk_distance * 1.5

func release_ability_1(target):
	var it = root.instantiate()
	it.position = target.position
	get_parent().add_child(it)

