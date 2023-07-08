class_name Swordman
extends Dude

var throwable_item = preload("res://scenes/dudes/Swordman/ThrowableItem.tscn")

@export var boost_timer:float = 5

@export var speed_boost_coef:float = 1.5

@export var damage_boost_coef:float = 1.5

func _ready():
	super._ready()

func deal_damage(target):
	var vec = target.position - position
	var s_x = sign(vec.x)
	var s_y = sign(vec.y)
	if vec.length() <= atk_distance:
		if s_x != int(sprite.flip_h) * 2 - 1 and s_y == int(is_normal) * 2 - 1:
			target.take_damage(damage)


func ability_1_custom_condition():
	var vec = target.position - position
	return vec.length() > atk_distance * 1.2

func release_ability_1(target):
	var it = throwable_item.instantiate()
	it.point = target.position
	it.position = position
	get_parent().add_child(it)
	
func release_ability_2(target):
	speed *= speed_boost_coef
	damage *= damage_boost_coef
	await get_tree().create_timer(boost_timer).timeout
	speed /= speed_boost_coef
	damage /=damage_boost_coef
