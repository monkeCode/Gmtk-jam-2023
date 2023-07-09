extends Dude
class_name Rogue

var bomb = preload("res://scenes/dudes/Bomb.tscn")
@export var bombs_count:int = 10

func release_ability_1(target):
	var start_angle = randf_range(0, 2*PI)
	var distance = (target.position-position).length()
	for i in range(0, bombs_count):
		var b = bomb.instantiate()
		b.position = position
		var point = randi_range(0, distance)
		var vec = Vector2(cos(2*PI*i/bombs_count), sin(2*PI*i/bombs_count)).normalized()
		b.point = vec * point + position
		get_tree().get_root().get_child(0).add_child(b)
		b.throw()
	

func release_ability_2(target):
	var b = bomb.instantiate()
	b.position = position
	get_tree().get_root().get_child(0).add_child(b)

func ability_1_custom_condition():
	return (target.position-position).length() > atk_distance


func _die():
	play_anim("die")
	can_change_state = false
	state = State.Die
	while true:
		await animator.frame_changed
		if animator.frame == 15:
			if(target.position-position).length() <= atk_distance*1.5:
				target.take_damage(damage*2)
				target.velocity += (target.position-position).normalized() * 20
			break
	await animator.animation_finished
	queue_free()
