extends Control
class_name FightUI

var hp_bar:HSlider

@export var item_i_image:TextureRect
@export var item_2_image:TextureRect

@export var item_1_cd:Label
@export var item_2_cd:Label

func _ready():
	hp_bar = $HSlider

func _process(delta):
	pass

func _on_hp_changed(last, newHp, max):
	var val = int(float(newHp)/max * 100)
	hp_bar.value = val


func start_cd_item(label, cooldown):
	
	for i in range(0,cooldown+1):
		await get_tree().create_timer(1).timeout
		label.text = str(cooldown-i)


func _on_player_item_used(item_num, item:Item):
	var l = null
	if item_num == 0:
		l = item_1_cd
	else: 
		l = item_2_cd
	start_cd_item(l, item.cooldown)
