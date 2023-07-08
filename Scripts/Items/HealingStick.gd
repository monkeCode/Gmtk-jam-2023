class_name HealingStick
extends Item

@export var heals:int = 10

func use_item(caster):
	caster.heal(heals)
