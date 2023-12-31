extends PanelContainer

const MAX_ITEMS=2
const SLOT=preload("res://scenes/UI/slot.tscn")
@onready var slot = $MarginContainer/GridContainer/Slot
@onready var slot_2 = $MarginContainer/GridContainer/Slot2
@onready var slot_3 = $MarginContainer/GridContainer/Slot3
@onready var slot_4 = $MarginContainer/GridContainer/Slot4
@onready var slot_5 = $MarginContainer/GridContainer/Slot5
@onready var slot_6 = $MarginContainer/GridContainer/Slot6
@onready var grid_container = $MarginContainer/GridContainer

@onready var items_choosed = []

signal weapons_are_choosed(items)


func _on_slot_toggled(button_pressed):
	add_item(slot.item)
	slot.disconnect("toggled", _on_slot_toggled)


func _on_slot_2_toggled(button_pressed):
	add_item(slot_2.item)
	slot_2.disconnect("toggled", _on_slot_2_toggled)
	
func _on_slot_3_toggled(button_pressed):
	add_item(slot_3.item)
	slot_3.disconnect("toggled", _on_slot_3_toggled)

func _on_slot_4_toggled(button_pressed):
	add_item(slot_4.item)
	slot_4.disconnect("toggled", _on_slot_4_toggled)

func _on_slot_5_toggled(button_pressed):
	add_item(slot_5.item)
	slot_5.disconnect("toggled", _on_slot_5_toggled)

func _on_slot_6_toggled(button_pressed):
	add_item(slot_6.item)
	slot_6.disconnect("toggled", _on_slot_6_toggled)
	
func add_item(item):
	items_choosed.append(item)
	print(items_choosed.size())
	if items_choosed.size()>=MAX_ITEMS:
		emit_signal("weapons_are_choosed", items_choosed)

