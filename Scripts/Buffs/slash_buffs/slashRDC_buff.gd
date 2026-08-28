extends Node

@onready var parent_node: Node3D = $".."


@export var damage: float = 55
@export var cooldown: float = 1.5
func _ready() -> void:
	#somehow add range first simply make the slash bigger
	print(parent_node.gpu_particles_3d.scale)
	parent_node.gpu_particles_3d.scale = Vector3(10,10,10)
	print(parent_node.gpu_particles_3d.scale)
	parent_node.collision_shape_3d.scale = Vector3(4,2.17,4)
	parent_node.slash_damage = damage
	parent_node.timer.wait_time = cooldown
