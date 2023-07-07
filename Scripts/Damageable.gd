class_name Damageable
extends Node

@export
var _health : int
@export
var _max_health:int

func get_health() -> int:
	return _health

func get_max_health() -> int:
	return _max_health

func heal(value:int) -> void:
	_health = min(get_max_health(), _health+ value)

func take_damage(value:int) -> void:
	_health -= value
	if(_health <=0):
		_die()
	
func kill() -> void:
	_die()

func _die() -> void:
	queue_free()

