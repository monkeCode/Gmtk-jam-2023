extends Node2D
class_name Fireball

var damage:int = 1
var time:float =1

@export var radius:float = 40
@export var force:float = 200
@export var speed:float  = 5

var move_target
var x:float = 0
var start_angle = 0

func _ready():
	await get_tree().create_timer(time).timeout
	queue_free()
	
func _process(delta):
	x+= delta * speed
	position = move_target.position + \
		Vector2(cos(x+ start_angle),sin(x+ start_angle)).normalized() * radius
	


func _on_area_2d_body_entered(body):
	if body is Damageable:
		body.take_damage(damage)
		var push_vec = (body.position - move_target.position).normalized()
		body.velocity += push_vec * force
