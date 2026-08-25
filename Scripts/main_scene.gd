extends Node3D

@onready var spawn_area: Area3D = $SpawnArea

var enemy = preload("res://Scenes/Enemy.tscn")

var enemy_count = 4
var enemy_pos_arr = []
var current_enemy_count = 0


func _ready() -> void:
	while enemy_count>current_enemy_count:
		add_enemy_position()
	print(enemy_pos_arr)
	
	if !enemy_pos_arr.is_empty():
		spawn_enemies(enemy_pos_arr)
	print(enemy_pos_arr)
	
func _physics_process(_delta: float) -> void:
	if current_enemy_count <= 0:
		while enemy_count>current_enemy_count:
			add_enemy_position()
		spawn_enemies(enemy_pos_arr)

func spawn_enemies(enemy_pos_array):
	for enemy_pos_vec in enemy_pos_array:
		var enemy_inst = enemy.instantiate()
		add_child(enemy_inst)
		enemy_inst.global_position = enemy_pos_vec
	enemy_pos_array.clear()

func add_enemy_position():
	var collisionShape: CollisionShape3D = spawn_area.get_child(-1)
	
	if collisionShape.shape is BoxShape3D:
		var halfSize = collisionShape.shape.size/2
		var pos = collisionShape.global_position + get_random_point(halfSize)
		if pos in enemy_pos_arr:
			add_enemy_position()
		else: 
			current_enemy_count += 1
			enemy_pos_arr.push_back(pos)


func get_random_point(area)-> Vector3:
	var xPos = randf_range(-area.x,area.x)+ global_position.x
	var zPos = randf_range(-area.z,area.z)+ global_position.z
	
	return Vector3(xPos,1.0,zPos)
