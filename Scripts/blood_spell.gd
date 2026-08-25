extends Node3D

@onready var shooting_range: Area3D = $Range

var blood_spell_vfx = preload("res://Fireball_VFX/blood_spell.tscn")

var can_shoot = false
var damage : float = 100.0

func _on_timer_timeout() -> void:
	can_shoot = true
	for body in shooting_range.get_overlapping_bodies():
		if body.is_in_group("enemy") && can_shoot:
			look_at(body.global_position,Vector3.UP)
			body.take_damage(damage)
			shoot()
			break


func shoot()->void:
	can_shoot = false
	var blood_spell_inst = blood_spell_vfx.instantiate()
	get_tree().current_scene.add_child(blood_spell_inst)
	blood_spell_inst.global_transform = global_transform
