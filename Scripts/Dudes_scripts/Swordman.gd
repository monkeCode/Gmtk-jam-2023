class_name Swordman
extends Dude

var can_roar = true
var can_throw = true

func _ready():
	super._ready()


func deal_damage(target):
	var vec = target.position - position
	var s_x = sign(vec.x)
	var s_y = sign(vec.y)
	if vec.length() <= atk_distance:
		if s_x != int(sprite.flip_h) * 2 -1 and s_y == int(is_normal) * 2 -1:
			target.take_damage(damage)


func ability_2_custom_condition():
	var vec = target.position - position
	return vec.length() > atk_distance*1.2
