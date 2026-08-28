extends Node

@onready var parent_node: Node3D = $".."


@export var damage: float = 55
@export var cooldown: float = 1.5
func _ready() -> void:
	#somehow add range first simply make the slash bigger
	print(parent_node.scale)
	parent_node.scale = Vector3(2,1,2)
	print(parent_node.scale)
	print(parent_node.gpu_particles_3d.scale)
	var mat = parent_node.gpu_particles_3d.process_material as ParticleProcessMaterial
	if mat:
		# original min max is 1.8
		mat.scale_min = 3.6
		mat.scale_max = 3.6
		
		# restarting the particles to force the gpu to load it with my sacling properties
		parent_node.gpu_particles_3d.restart() 
	parent_node.slash_damage = damage
	parent_node.timer.wait_time = cooldown
