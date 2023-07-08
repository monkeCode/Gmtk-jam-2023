extends Resource

class_name Item

@export var name:String
@export_multiline var description:String
@export var texture:AtlasTexture

@export var cooldown : float

@export var manacost : int

var image_ref

func use_item():
	pass

func _process(delta):
	pass
