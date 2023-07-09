extends Item
class_name FireBalls

@export var lifetime: float = 10
@export var damage:float = 5
@export var count_balls:int = 4

var ball_prefab = preload("res://scenes/effects/Damagable_balls.tscn")

func use_item(caster):
	for i in range(0, count_balls):
		var angle = i * 2 * PI/ count_balls
		var ball = ball_prefab.instantiate()
		ball.damage = damage
		ball.time = lifetime
		ball.move_target = caster
		ball.start_angle = angle
		caster.get_tree().get_root().get_child(0).add_child(ball)
