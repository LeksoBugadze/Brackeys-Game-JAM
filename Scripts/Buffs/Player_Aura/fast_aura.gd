extends Node

@onready var parent_node: Node3D = $".."



func _ready() -> void:
	parent_node.damage = 15
	parent_node.damage_spehere.shape.radius = 7
	parent_node.mesh_instance_3d.mesh.radius = 7
	parent_node.mesh_instance_3d.mesh.height = 7 * 2.0 
	print(parent_node.damage_spehere.shape.radius)
