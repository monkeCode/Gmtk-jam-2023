extends Node2D

@onready var cpu_particles_2d = $CPUParticles2D
@onready var area = $Area2D

@export var damage:int = 10
@export var damages_count:int = 3
@export var damage_delay:float = 1

var bodies = []

func _ready():
	cpu_particles_2d.emitting = true
	await get_tree().create_timer(1).timeout
	area.monitoring = false
	deal_damages()

func deal_damages():
	for i in range(0, damages_count):
		for b in bodies:
			b.take_damage(damage)
		await get_tree().create_timer(damage_delay).timeout 
	queue_free()

func _on_area_2d_body_entered(body):
	if body is Damageable:
		bodies.append(body)

