extends Node3D

@onready var shooting_range: Area3D = $Range
@onready var cooldown: Timer = $cooldown 

var lightning_strike_vfx = preload("res://Lightning_VFX/Lightning_strike_scene.tscn")

var can_shoot = false
var hit_all_targets = false
var damage : float = 20.0

func _on_cooldown_timeout() -> void:
	can_shoot = true
	for body in shooting_range.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			if can_shoot || hit_all_targets:
				var projectile = shoot(body)
				projectile.collided_lightning.connect(_on_proj_hit)


func shoot(enemy)->Area3D:
	can_shoot = false
	var lightning_strike_inst = lightning_strike_vfx.instantiate()
	get_tree().current_scene.add_child(lightning_strike_inst)
	lightning_strike_inst.global_transform = enemy.global_transform
	
	return lightning_strike_inst

func _on_proj_hit(hit_node):
	if hit_node.has_method("take_damage"):
		Lightingsound.play()
		hit_node.take_damage(damage)
