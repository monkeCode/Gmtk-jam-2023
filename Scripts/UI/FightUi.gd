extends Control
class_name FightUI

var hp_bar:HSlider



func _ready():
	hp_bar = $HSlider



func _process(delta):
	pass

func _on_hp_changed(last, newHp, max):
	var val = int(float(newHp)/max * 100)
	hp_bar.value = val
	
