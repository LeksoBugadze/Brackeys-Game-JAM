extends Node3D

@onready var node_3d: Area3D = $Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var slash_damage: float = 45.0

func _physics_process(_delta: float) -> void:
	rotation.y = get_parent().get_node_or_null("MeshInstance3D").rotation.y

func player_hit() -> void:
	animation_player.play("RESET") 
	for body in node_3d.get_overlapping_bodies():
		if body.is_in_group("enemy") and body.has_method("take_damage"):	
			body.take_damage(slash_damage)

func _on_timer_timeout() -> void:
	player_hit()
