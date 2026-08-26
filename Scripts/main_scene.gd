extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var enemy_container: Node3D = $enemyContainer
@onready var timer: Timer = $Timer
@onready var time_label: Label = $CanvasLayer/Time_label
@onready var spawn_area: Area3D = $SpawnArea

var enemy = preload("res://Scenes/Enemy.tscn")

var blood_spell = preload("res://Scenes/blood_spell_ability.tscn")
var lightning_spell = preload("res://Scenes/lightning_strike_ability.tscn")

var enemy_count = 3
var enemy_pos_arr = []
var current_enemy_count = 0
var wave_time :float = 20.0
var cleared = true

func _ready() -> void:
	start_wave()
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("test_start_new_wave"):
		current_enemy_count = 0
		start_wave()
		
	if Input.is_action_just_pressed("add_blood_spell"):
		player.add_child(blood_spell.instantiate())
		
	if Input.is_action_just_pressed("add_lightning_spell"):
		player.add_child(lightning_spell.instantiate())
		
	time_label.text = str(int(timer.time_left))
	if cleared == false:
		if current_enemy_count <= 0:
			while enemy_count>current_enemy_count:
				add_enemy_position()
			spawn_enemies(enemy_pos_arr)
			
func start_wave():
	if cleared == true:
		timer.wait_time = wave_time
		timer.start()
		while enemy_count>current_enemy_count:
			add_enemy_position()
		print(enemy_pos_arr)
		
		if !enemy_pos_arr.is_empty():
			spawn_enemies(enemy_pos_arr)
		print(enemy_pos_arr)
	cleared = false

func spawn_enemies(enemy_pos_array):
	enemy_count +=1
	for enemy_pos_vec in enemy_pos_array:
		var enemy_inst = enemy.instantiate()
		enemy_container.add_child(enemy_inst)
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

func _on_timer_timeout() -> void:
	timer.stop()
	for child_enemy in enemy_container.get_children():
		child_enemy.free()
	cleared = true
