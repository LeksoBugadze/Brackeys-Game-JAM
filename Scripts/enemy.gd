extends CharacterBody3D

var movement_speed :float = 2.5
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var damage_range: Area3D = $damageRange

var player : CharacterBody3D = null
var can_attack = false

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]

func _process(_delta: float) -> void:
	navigation_agent_3d.set_target_position(player.global_position)

func _physics_process(_delta: float) -> void:
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
