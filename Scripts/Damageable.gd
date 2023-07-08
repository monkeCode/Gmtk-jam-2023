class_name Damageable
extends CharacterBody2D

signal hp_changed(last_hp, new_hp)

signal died

var damaged_text = preload("res://scenes/UI/DamagableText.tscn")

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
	show_text(_health - last_hp, DamagableText.Type.Heal)

func show_text(str, type):
	var text = damaged_text.instantiate()
	var pos = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized() * 5 + position
	text.position = pos
	get_tree().get_root().get_child(0).add_child(text)
	text.set_text(str(str), type)

func take_damage(value:int) -> void:
	var last_hp = _health
	_health -= value
	hp_changed.emit(last_hp, max(0, _health))
	show_text(last_hp - _health, DamagableText.Type.Damage)
	
	if(_health <=0):
		_die()
	
func kill() -> void:
	_die()

func _die() -> void:
	died.emit()
	queue_free()

