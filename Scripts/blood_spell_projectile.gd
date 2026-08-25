extends CharacterBody3D


func _physics_process(_delta: float) -> void:
	velocity = -transform.basis.z * 35
	
	var collided_this_frame: bool = move_and_slide()
	
	if collided_this_frame:
		queue_free()
