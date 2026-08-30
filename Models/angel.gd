extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cube: MeshInstance3D = $Armature/Skeleton3D/Cube
@onready var label: Label = $CanvasLayer/Label
@onready var area_3d: Area3D = $Area3D
@onready var current_scene = get_tree().current_scene
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var canvas_layer = get_tree().current_scene.get_node("CanvasLayer")


var ability_scene = preload("res://UI/ability_scene.tscn")

func _ready() -> void:
	animation_player.play("ArmatureAction")


func _physics_process(_delta: float) -> void:
	for body in area_3d.get_overlapping_bodies():
		if body.is_in_group("player") && get_tree().paused == false:
			label.visible = true
			


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact")&& get_tree().paused == false:
		if current_scene.wave_count == 5:
			player.current_health += 50
			player.update_health_bar()
			get_tree().paused = false
			queue_free()
			current_scene.current_enemy_count = 0
			current_scene.start_wave()
		else:
			canvas_layer.add_child(ability_scene.instantiate())
		
