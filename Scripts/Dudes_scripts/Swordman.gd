class_name Swordman
extends Dude

func _ready():
	super._ready()


func deal_damage(target):
	var vec = target.position - position
	if vec.length() <= atk_distance:
		target.take_damage(damage)
