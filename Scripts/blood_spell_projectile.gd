extends CharacterBody3D

signal collided(hit_node: CharacterBody3D)


func _physics_process(_delta: float) -> void:
	velocity = -transform.basis.z * 50
	
	var collided_this_frame: bool = move_and_slide()
	
	if collided_this_frame:
		var hit_node = get_last_slide_collision().get_collider()
		if hit_node:
			collided.emit(hit_node)
			queue_free()

func _on_timer_timeout() -> void:
	queue_free()
