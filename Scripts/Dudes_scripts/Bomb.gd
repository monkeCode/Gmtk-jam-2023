extends ThrowableItem
class_name Bomb

@export var bounce_count: int = 3

@export var bounce_coef:float = 0.5

@export var timer:float = 5

@onready var animated:AnimatedSprite2D = $AnimatedSprite2D


var throwed: bool= false
var is_explosed = false
var last_pos = position
var x_total = 0
func init():
	super.init()

func throw():
	throwed = true
	
func _physics_process(delta):
	if throwed:
		x+=delta
		x_total+=delta
		if x > time:
			bounce_count -=1
			if bounce_count > 0:
				point = point + move_vec * bounce_coef
				height_coef *= bounce_coef
				init()
				x = 0
	if x_total >= timer and !is_explosed:
		is_explosed = true
		explose()
	calculate_pos()
	rotation = Vector2.RIGHT.angle_to(position-last_pos)


func explose():
	animated.play("explode")
	await animated.animation_finished
	for b in bodies:
		b.take_damage(damage)
		queue_free()
		return
	
