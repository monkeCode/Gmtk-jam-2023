extends Item
class_name ImmuneShield

@export var imunneTime:float = 1

var effect = preload("res://scenes/effects/shield.tscn")

func use_item(caster):
	caster.damage_resist += 10000
	var s = effect.instantiate()
	caster.add_child(s)
	await caster.get_tree().create_timer(imunneTime).timeout
	caster.damage_resist -= 10000
	caster.remove_child(s)
