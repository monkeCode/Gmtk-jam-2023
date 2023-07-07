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

@export_category("Stats")

@export 
var speed:float = 0
@export 
var damage:int = 0

@export_category("abilities")

@export var ability_1_cooldown:float = 0
@export var ability_1_chance: int = 10

@export var ability_2_cooldown:float = 0
@export var ability_2_chance: int = 10

var can_ability_1 = true
var can_ability_2 = true

@export
var atk_distance:float = 0

@export
var target:Damageable = null

var animator:AnimatedSprite2D

var sprite:AnimatedSprite2D

var state

var is_normal = true

var can_change_state = true 

func _ready(): 
	state = State.Idle
	animator = $AnimatedSprite2D
	sprite = $AnimatedSprite2D

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
	play_anim("move")
	
func attack(target):
	can_change_state = false
	play_anim('atk')
	await animator.animation_finished
	deal_damage(target)
	can_change_state = true

func deal_damage(target):
	print_debug("deal_damage")

func ability_1(target):
	can_change_state = false
	play_anim("ability_1")
	await animator.animation_finished
	release_ability_1(target)
	can_change_state = true
	cooldown_ability_1()
	
func release_ability_1(target):
	pass
	
func release_ability_2(target):
	pass
	
func ability_2(target):
	can_change_state = false
	play_anim("ability_2")
	await animator.animation_finished
	release_ability_2(target)
	can_change_state = true
	cooldown_ability_2()

func cooldown_ability_1():
	can_ability_1 = false
	await get_tree().create_timer(ability_1_cooldown).timeout
	can_ability_1 = true

func cooldown_ability_2():
	can_ability_2 = false
	await get_tree().create_timer(ability_2_cooldown).timeout
	can_ability_2 = true

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
	return can_ability_1 and ability_1_custom_condition() and get_chance()<=ability_1_chance

func ability_1_custom_condition():
	return true
	
func ability_2_condition():
	return can_ability_2 and ability_2_custom_condition() and get_chance()<=ability_2_chance

func ability_2_custom_condition():
	return true
	
func play_anim(anim_name):
	if is_normal:
		animator.play(anim_name + "_normal")
	else:
		animator.play(anim_name +"_backside")
		if(animator.animation != anim_name + "_backside"):
			animator.play(anim_name + "_normal")
		
func take_damage(dmg):
	if get_health() <=0:
		return
	can_change_state = false
	state = State.Take_damage
	play_anim("take_damage")
	super.take_damage(dmg)

func _die():
	play_anim("die")
	can_change_state = false
	state = State.Die
	await animator.animation_finished
	queue_free()

func get_chance():
	return randi() % 100 + 1

