extends Node

@export var damage:int = 10

var bodies = []

func _ready():
	var animator = $AnimatedSprite2D
	await animator.animation_finished
	for i in bodies:
		i.take_damage(damage)
	animator.play("aft_atk")
	await animator.animation_finished
	queue_free()



func _on_area_2d_area_entered(area):
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if body is Damageable:
		bodies.append(body)


func _on_area_2d_body_exited(body):
	if body in bodies:
		bodies.erase(body)
