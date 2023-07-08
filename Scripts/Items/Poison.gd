class_name Poison
extends Item

var zone = preload("res://scenes/effects/poison_zone.tscn")

func use_item(caster):
	var z = zone.instantiate()
	z.position= caster.position
	caster.get_tree().get_root().get_child(0).add_child(z)
