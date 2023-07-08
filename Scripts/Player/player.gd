extends Damageable

class_name Player

signal item_used(int,Item)

@export var speed = 300.0
@export var friction = 200.0

enum State{
	Move,
	Idle,
	Die,
	Atk,
	Ability_1,
	Ability_2,
	Take_damage
	}

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_range = $Attack_range
@onready var state = State.Idle

var can_change_state = true 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var front=1
var horizontal_direction=1

signal facing_direction_changed(facing_right:bool, facing_front:bool, hor_dir:bool)

func _physics_process(delta):
	velocity.x = move_toward(velocity.x, 0, friction*delta)
	velocity.y = move_toward(velocity.y, 0, friction*delta)
	if can_change_state:
		thinking()
	match state:
		State.Move:
			handle_move(delta)
		State.Atk:
			handle_atk()
		State.Idle:
			if front==1:
				animated_sprite_2d.play("idle-front")
			else:
				animated_sprite_2d.play("idle-back")
	move_and_slide()

func handle_atk():
	can_change_state=false
	attack_range.monitoring=true
	if horizontal_direction==0 and front==0:
		animated_sprite_2d.play("attack_back")
	else:
		animated_sprite_2d.play("attack")
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * speed * 2
		print(velocity.x)
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * speed * 2
	await animated_sprite_2d.animation_finished
	attack_range.monitoring=false
	can_change_state=true
	
# ПИЗДЕЦ
func handle_move(delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * speed
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * speed
	if direction_x==0:
		if direction_y>0:
			animated_sprite_2d.play("run-front")
			front=1
			horizontal_direction=0
		else:
			animated_sprite_2d.play("run-back")
			front=0
			horizontal_direction=0
	else:
		animated_sprite_2d.flip_h=(velocity.x<0)
		front=1
		animated_sprite_2d.play("run-horizontal")
		horizontal_direction=1
	emit_signal("facing_direction_changed", !animated_sprite_2d.flip_h, front, horizontal_direction)

func thinking():
	if Input.is_action_pressed("ui_accept"):
		state = State.Atk
		return
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left"):
		state = State.Move
		return
	state = State.Idle

func take_damage(dmg):
	if get_health() <=0:
		return
	state=State.Take_damage
	can_change_state=false
	if front==0 and horizontal_direction==0:
		animated_sprite_2d.play("took_damage_back")
	else:
		animated_sprite_2d.play("took_damage")
	super.take_damage(dmg)
	await animated_sprite_2d.animation_finished
	can_change_state=true

func _die():
	state=State.Die
	can_change_state=false
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()


