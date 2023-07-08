extends Item
class_name ImmuneShield

@export var imunneTime:float = 1

func use_item(caster):
	var last_resist = caster.damage_resist
	caster.damage_resist = 10000
	await caster.get_tree().create_timer(imunneTime).timeout
	caster.damage_resist = last_resist
