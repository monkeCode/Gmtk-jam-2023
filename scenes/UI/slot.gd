extends BaseButton
@onready var texture_rect = $MarginContainer/TextureRect
@export var item:Item
func _ready():
	set_item_data(item)

func set_item_data(item_data: Item) -> void:
	texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]
	
	
