extends Area3D

@export var damage: float = 10.0
@export var zone_radius: float = 5.0

func apply_aura_damage() -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy"):
			if body.has_method("take_damage"):
				body.take_damage(damage)


func _on_timer_timeout() -> void:
	apply_aura_damage()
