extends Node

@onready var parent_node: Node3D = $".."
@export var new_damage: float = 20
@export var new_cd: float = 1.5

func _ready() -> void:
	parent_node.damage = new_damage
	parent_node.timer.wait_time = new_cd
	
	
	print(parent_node.damage,",",parent_node.timer.wait_time)
