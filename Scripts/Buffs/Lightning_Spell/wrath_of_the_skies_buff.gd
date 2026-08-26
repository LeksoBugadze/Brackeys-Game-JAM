extends Node3D

@onready var lightning_spell: Node3D = $".."

func _ready() -> void:
	lightning_spell.hit_all_targets = true
	lightning_spell.cooldown.wait_time += 0.5
