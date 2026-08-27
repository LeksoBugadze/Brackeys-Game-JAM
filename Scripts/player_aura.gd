extends Area3D

@export var damage: float = 20



@export var zone_radius: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$DamageSpehere.shape.radius = zone_radius
	
	
	$MeshInstance3D.mesh.radius = zone_radius
	$MeshInstance3D.mesh.height = zone_radius * 2.0 


func apply_aura_damage() -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy"):
			if body.has_method("take_damage"):
				print("enemy is withing aura dealt damage: ", damage)
				body.take_damage(damage)
			else:
				print("there is not method called take_damage")
			


func _on_timer_timeout() -> void:
	print("activated main ready function")
	apply_aura_damage()
