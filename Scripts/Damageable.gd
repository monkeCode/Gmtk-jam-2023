class_name Damageable
extends CharacterBody2D

signal hp_changed(last_hp, new_hp)

signal died

@export
var _health : int
@export
var _max_health:int

func get_health() -> int:
	return _health

func get_max_health() -> int:
	return _max_health

func heal(value:int) -> void:
	var last_hp = _health
	_health = min(get_max_health(), _health+ value)
	hp_changed.emit(last_hp, _health)

func take_damage(value:int) -> void:
	var last_hp = _health
	_health -= value
	hp_changed.emit(last_hp, max(0, _health))
	
	if(_health <=0):
		_die()
	
func kill() -> void:
	_die()

func _die() -> void:
	died.emit()
	queue_free()

