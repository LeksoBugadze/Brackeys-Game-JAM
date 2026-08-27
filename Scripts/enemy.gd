extends CharacterBody3D

var movement_speed :float = 2.5
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var damage_range: Area3D = $damageRange
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

var damage_flash_material = preload("res://Materials/damage_flash_material.tres")

var health : float = 100.0
var knocked :bool = false
var chase :bool = true
var player : CharacterBody3D = null
var can_attack = false

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]

func _process(_delta: float) -> void:
	if health <=0:
		get_tree().current_scene.current_enemy_count -= 1
		queue_free()
	
	navigation_agent_3d.set_target_position(player.global_position)

func _physics_process(_delta: float) -> void:
	if knocked:
		velocity = -transform.basis.z * 500
		await get_tree().create_timer(0.2).timeout
		knocked = false
	
	if chase:
		for body in damage_range.get_overlapping_bodies():
			if body.is_in_group("player") && can_attack:
				body.take_damage(10.0)
				can_attack = false
				
		if navigation_agent_3d.is_navigation_finished():
			return
		
		var next_position:Vector3 = navigation_agent_3d.get_next_path_position()
		velocity = global_position.direction_to( next_position ) * movement_speed
	move_and_slide()
	
func _on_timer_timeout() -> void:
	can_attack = true

func take_damage(damage:float)->void:
	health-=damage
	knocked = true
	flash_swap()
	

func flash_swap():
	mesh_instance_3d.material_override = damage_flash_material
	await get_tree().create_timer(0.2).timeout
	mesh_instance_3d.material_override = null
