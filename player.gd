extends Damageable

class_name Player

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_range = $Attack_range

const SPEED = 300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var front=1
var attack_flag=0
var timer

signal facing_direction_changed(facing_right:bool)

func _physics_process(delta):
	handle_move()
	handle_animation()
	handle_atk()
	move_and_slide()

func handle_atk():
	if Input.is_action_pressed("ui_select"):
		attack_flag=1
		attack_range.monitoring=true
		animated_sprite_2d.play("attack")
		await animated_sprite_2d.animation_finished
		attack_flag=0
		attack_range.monitoring=false
	
func handle_move():
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

func handle_animation():
	if attack_flag==0:
		if velocity.x==0:
			if velocity.y==0:
				if front==1:
					animated_sprite_2d.play("idle-front")
				else:
					animated_sprite_2d.play("idle-back")
			elif velocity.y>0:
				animated_sprite_2d.play("run-front")
				front=1
			else:
				animated_sprite_2d.play("run-back")
				front=0
		else:
			animated_sprite_2d.flip_h=(velocity.x<0)
			emit_signal("facing_direction_changed", !animated_sprite_2d.flip_h)
			front=1
			animated_sprite_2d.play("run-horizontal")


	
	
	
