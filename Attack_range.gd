extends Area2D



func _ready():
	monitoring=false


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is Damageable and body :
		body.take_damage(20)
		
