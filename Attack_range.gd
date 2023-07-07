extends Area2D

@export var damage : int = 10
@export var player : Player
@export var facing_shape : FacingRightDirectionCollisionShape


func _ready():
	monitoring=false
	player.connect("facing_direction_changed", _direction_changer)


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is Damageable:
		body.take_damage(damage)
		print("took damage")
		
func _direction_changer(facing_right:bool):
	if (facing_right):
		facing_shape.position = facing_shape.facing_right_position
	else:
		facing_shape.position = facing_shape.facing_left_position
	
