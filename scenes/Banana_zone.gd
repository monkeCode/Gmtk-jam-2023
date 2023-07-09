extends Node2D

@export var force:float = 3

var can_slide = false

func _ready():
	await get_tree().create_timer(1).timeout
	can_slide = true
	

func _on_area_2d_body_entered(body):
	if !can_slide:
		return
	if body is Damageable:
		body.take_damage(1)
		body.velocity *= force
		queue_free()
