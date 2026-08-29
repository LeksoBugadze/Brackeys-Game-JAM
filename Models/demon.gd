extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cube: MeshInstance3D = $Armature/Skeleton3D/Cube
@onready var label: Label = $CanvasLayer/Label
@onready var area_3d: Area3D = $Area3D

@onready var canvas_layer = get_tree().current_scene.get_node("CanvasLayer")
var buff_scene = preload("res://UI/select_buff.tscn")

func _ready() -> void:
	animation_player.play("ArmatureAction")


func _physics_process(_delta: float) -> void:
	for body in area_3d.get_overlapping_bodies():
		if body.is_in_group("player"):
			label.visible = true
			


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		canvas_layer.add_child(buff_scene.instantiate())
	
		
