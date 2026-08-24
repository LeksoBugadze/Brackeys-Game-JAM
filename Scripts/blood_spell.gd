extends Node3D

@onready var shooting_range: Area3D = $Range
var blood_spell_vfx = preload("res://Fireball_VFX/blood_spell.tscn")


func _on_timer_timeout() -> void:
	for body in shooting_range.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			print(body)
			look_at(body.position)
			var blood_spell_inst = blood_spell_vfx.instantiate()
			add_child(blood_spell_inst)
			blood_spell_inst.global_position = position
