class_name ThrowableItem
extends Node2D

@export var damage:int = 10

@export var speed:float = 10

@export var height_coef:float = 1

@export var point:Vector2 = Vector2.ZERO

var start_pos:Vector2

var x:float = 0

var time:float = 0

var move_vec

func _ready():
	init()
	

func init():
	start_pos = position
	move_vec = point - position
	time = move_vec.length() / speed

func _physics_process(delta):
	x+=delta
	rotation = 2*PI * x/time * 5
	if x > time:
		for b in bodies:
			b.take_damage(damage)
		queue_free()
		return
	calculate_pos()

func calculate_pos():
	var percent = x/time
	var x_pos = percent * PI
	var y_pos = -height_coef * sin(x_pos)
	
	var x_offseted = percent * (move_vec.x-1) + start_pos.x
	var y_offseted = y_pos + percent * move_vec.y + start_pos.y
	
	position = Vector2(x_offseted, y_offseted)


var bodies = []

func _on_area_2d_body_entered(body):
	if body is Damageable:
		bodies.append(body)


func _on_area_2d_body_exited(body):
	if body is Damageable:
		bodies.erase(body)
