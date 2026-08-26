extends Node3D

@onready var blood_spell: Node3D = $".."

func _ready() -> void:
	blood_spell.damage -= blood_spell.damage/4
	blood_spell.hit_all_targets = true
	
