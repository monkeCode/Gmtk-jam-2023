extends PanelContainer

const SLOT=preload("res://scenes/UI/slot.tscn")

@onready var grid_container = $MarginContainer/GridContainer

func _ready() -> void:
	var inv_data=preload("res://scenes/InventoryChoose.tres")
	populate_grid(inv_data.items)

func populate_grid(items: Array[Item]) -> void:
	for child in grid_container.get_children():
		child.queue_free()
		
	for item in items:
		var slot=SLOT.instantiate()
		grid_container.add_child(slot)
		
		if item:
			slot.set_item_data(item)
