class_name Dude
extends Damageable

enum State{
	Move,
	Idle,
	Die,
	Atk,
	Ability_1,
	Ability_2,
	Take_damage
	}

@export 
var speed:float = 0
@export 
var atk:int = 0

@export
var atk_distance:float = 0

var target = null

var animator:AnimatedSprite2D

var sprite:AnimatedSprite2D

var state

var is_normal = true

var can_change_state = true 

func _ready(): 
	state = State.Idle
	animator = $AnimatedSprite2D
	sprite = $AnimatedSprite2D
	target = get_tree().get_root().get_node("test_dudes scene").get_node("target")

func _process(delta):
		
	if can_change_state:
		thinking()
		print(state)
		match state:
			State.Move:
				move(target.position, delta)
				move_and_slide()
			State.Atk:
				attack(target)
			State.Ability_1:
				ability_1(target)
			State.Ability_2:
				ability_2(target)
			State.Idle:
				if is_normal:
					animator.play("idle_normal")
				else:
					animator.play("idle_backside")
	sprite.flip_h = velocity.x < 0
	

func move(point, delta):
	var dir = (point - position).normalized()
	velocity = dir * speed
	is_normal = velocity.y > 0
	if is_normal:
		animator.play("move_normal")
	else:
		animator.play("move_backside")
	
func attack(target):
	
	if is_normal:
		animator.play("atk_normal")
	else:
		animator.play("atk_backside")

func ability_1(target):
	play_anim("ability_1")

func ability_2(target):
	play_anim("ability_2")

func thinking():
	if ability_1_condition():
		state = State.Ability_1
		return
	if ability_2_condition():
		state = State.Ability_2
		return
	if target == null:
		state = State.Idle
	if (target.position - position).length() > atk_distance:
		state = State.Move
		return
	state = State.Atk
	
	
func ability_1_condition():
	return false
	
func ability_2_condition():
	return false
	
func play_anim(anim_name):
	if is_normal:
		animator.play(anim_name + "_normal")
	else:
		animator.play(anim_name +"_backside")
		
func take_damage(dmg):
	can_change_state = false
	state = State.Take_damage
	super.take_damage(dmg)

func _die():
	can_change_state = false
	state = State.Die
	play_anim("die")
	await animator.animation_finished
	queue_free()
