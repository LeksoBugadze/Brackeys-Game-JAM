extends Area3D

@export var damage: float = 10.0
@export var zone_radius: float = 5.0
@onready var damage_spehere: CollisionShape3D = $DamageSpehere
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var timer: Timer = $Timer

func apply_aura_damage() -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy"):
			if body.has_method("take_damage"):
				body.take_damage(damage)


func _on_timer_timeout() -> void:
	apply_aura_damage()
