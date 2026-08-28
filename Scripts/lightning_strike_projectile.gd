extends Area3D

@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D

signal collided_lightning(hit_node: CharacterBody3D)
var hit = false

func _ready() -> void:
	gpu_particles_3d.emitting = true
	await gpu_particles_3d.finished
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if hit ==false:
		hit = true
		collided_lightning.emit(body)
