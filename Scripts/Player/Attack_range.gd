extends Area2D


@export var damage : int = 10
@export var player : Player
@export var facing_shape : FacingRightDirectionCollisionShape


func _ready():
	monitoring=false
	player.connect("facing_direction_changed", _direction_changer)


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group('ground'):
		var velocity = player.velocity
		var normal = (player.position-body.position).normalized()
		var reflect = velocity.bounce(normal)
		player.velocity = reflect
		
	if body is Damageable:
		body.take_damage(damage)
		var dir = (body.position - player.position).normalized()
		body.velocity += dir * player.velocity.length()
		print("took damage")
		
func _direction_changer(facing_right:bool, facing_front:bool, hor_dir:bool):
	if (hor_dir):
		if (facing_right):
			facing_shape.position = facing_shape.facing_right_position
		else:
			facing_shape.position = facing_shape.facing_left_position
	else:
		if (facing_front):
			facing_shape.position = facing_shape.facing_down_position
		else:
			facing_shape.position = facing_shape.facing_up_position
	
