class_name Banana
extends Item

var banana_prefab = preload("res://scenes/Banana.tscn")

func use_item(caster):
	var z = banana_prefab.instantiate()
	z.position= caster.position
	caster.get_tree().get_root().get_child(0).add_child(z)
 
