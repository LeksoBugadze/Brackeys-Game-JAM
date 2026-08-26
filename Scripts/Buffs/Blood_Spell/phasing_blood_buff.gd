extends Node3D

@onready var blood_spell: Node3D = $".."

func _ready() -> void:
	blood_spell.cooldown.wait_time = 0.3
	blood_spell.damage /= 4.5
