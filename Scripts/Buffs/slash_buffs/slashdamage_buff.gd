extends Node

@onready var parent_node: Node3D = $".."


@export var slashdamage: float = 55
@export var cooldown: float = 0.5
func _ready() -> void:
	print(parent_node.slash_damage,parent_node.timer.wait_time)
	parent_node.slash_damage = slashdamage
	parent_node.timer.wait_time = cooldown
	print(parent_node.slash_damage,parent_node.timer.wait_time)
