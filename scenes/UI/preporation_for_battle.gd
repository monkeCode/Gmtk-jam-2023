extends Control
@onready var item_choose = $ItemChoose
@export var scene_to_load : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_choose_weapons_are_choosed(rap):
	StaticValues.item_1=rap[0]
	StaticValues.item_2=rap[1]
	get_tree().change_scene_to_packed(scene_to_load)
