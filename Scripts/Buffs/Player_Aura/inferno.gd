extends Node

@onready var parent_node: Node3D = $".."

func _ready() -> void:
	parent_node.mesh_instance_3d.scale.x *= 1.5
	parent_node.mesh_instance_3d.scale.z *= 1.5
	parent_node.damage_spehere.shape.radius *=1.5
	parent_node.damage = 15
	
