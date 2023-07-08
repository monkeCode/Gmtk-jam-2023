class_name Druid
extends Dude
@export_category("Root")
@export var root_count = 3
@export var root_radius:float = 1
var root = preload("res://scenes/dudes/druid/Root.tscn")

@export_category("Beast")
@export var boost_speed:float =  1.2
@export var boost_damage:float = 1.8
@export var best_timer:float = 10 

var is_human = true

func ability_1_custom_condition():
	var vec = target.position - position
	return vec.length() > atk_distance * 1.5 and is_human

func ability_2_custom_condition():
	return is_human

func release_ability_1(target):
	for i in range(0, root_count):
		var p = Vector2(randf_range(-1,1),  randf_range(-1,1)).normalized()
		var it = root.instantiate()
		it.position = target.position + p * root_radius
		get_parent().add_child(it)
		await get_tree().create_timer(0.1).timeout

func release_ability_2(target):
	is_human = false
	damage*=boost_damage
	speed*=boost_speed
	await get_tree().create_timer(best_timer).timeout
	is_human = true
	can_change_state = false
	animator.play("to_human")
	await animator.animation_finished
	can_change_state = true

func play_anim(anim):
	if is_human or anim == "die":
		super.play_anim(anim)
		return
	super.play_anim(anim+"_beast")
