extends ThrowableItem
class_name Bomb

@export var bounce_count: int = 3

@export var bounce_coef:float = 0.5

@export var timer:float = 5

@export var push_force:float = 20

@onready var animated:AnimatedSprite2D = $AnimatedSprite2D


var throwed: bool= false
var is_explosed = false
var last_pos = position
var x_total = 0

func init():
	super.init()

func throw():
	throwed = true
	animated.play("fly")
	
func _physics_process(delta):
	x_total+=delta
	if throwed:
		x+=delta
		if x > time:
			bounce_count -=1
			if bounce_count > 0:
				point = point + move_vec * bounce_coef
				height_coef *= bounce_coef
				init()
				x = 0
			else:
				animated.play("idle")
				throwed = false
				rotation = 0
				return
		rotation = Vector2.RIGHT.angle_to(position - last_pos)
		calculate_pos()
	if x_total >= timer and !is_explosed:
		is_explosed = true
		explose()
	


func explose():
	animated.play("explode")
	while true:
		await animated.frame_changed
		if animated.frame == 7:
			for b in bodies:
				b.take_damage(damage)
				b.velocity += (b.position-position).normalized() * push_force
			break
	await animated.animation_finished
	queue_free()
	
