extends Node2D
class_name DamagableText
enum Type{
	Heal,
	Damage,
	Info
}

@onready var label:Label = $Label

@export var speed: float = 10
@export var time: float = 1

@export_color_no_alpha var color_damage:Color
@export_color_no_alpha var color_heal:Color

var color:Color
var elapsed_time = 0

func _process(delta):
	position += delta*speed* Vector2.UP
	label.add_theme_color_override("font_color",Color(color, 1- elapsed_time / time) )
	elapsed_time += delta
	if(elapsed_time >= time):
		queue_free()

func set_text(str, type:Type):
	label.text = str
	match type:
		Type.Damage:
			color = color_damage
		Type.Heal:
			color = color_heal
		Type.Info:
			color = Color.WHITE
