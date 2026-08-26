extends Node3D

@onready var lightning_spell: Node3D = $".."

func _ready() -> void:
	lightning_spell.damage *= 1.5 
	lightning_spell.cooldown.wait_time += 0.5
