extends Control
class_name FightUI

var hp_bar:HSlider

@export var item_1_image:TextureRect
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

func start_cd_item(label,imag:TextureRect, cooldown):
	label.text = str(cooldown)
	imag.modulate = Color(Color.WHITE, 0.5)
	for i in range(0,cooldown+1):
		await get_tree().create_timer(1).timeout
		label.text = str(cooldown-i)
	imag.modulate = Color(Color.WHITE, 1)
	
func _on_player_item_used(item_num, item:Item):
	var l = null
	var i = null
	if item_num == 0:
		l = item_1_cd
		i = item_1_image
	else: 
		l = item_2_cd
		i = item_2_image
	start_cd_item(l, i, item.cooldown)

func _on_player_item_changed(item1, item2):
	item_1_image.texture = item1.texture
	item_2_image.texture = item2.texture
