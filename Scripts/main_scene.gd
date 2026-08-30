extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var enemy_container: Node3D = $enemyContainer
@onready var timer: Timer = $Timer
@onready var time_label: Label = $CanvasLayer/Time_label
@onready var spawn_area: Area3D = $SpawnArea
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var canvas_layer_2: CanvasLayer = $CanvasLayer2
@onready var wave_count_label: Label = $CanvasLayer/Wave_count
@onready var spawn_point: Marker3D = $spawn_point

var pause_menu = preload("res://UI/pause/Pause_menu.tscn")

var demon = preload("res://Models/demon.tscn")
var angel = preload("res://Models/angel.tscn")
var enemy = preload("res://Scenes/Enemy.tscn")
var dialog = preload("res://UI/dialog.tscn")

var enemy_count = 3
var enemy_pos_arr = []
var current_enemy_count = 0
var wave_time :float = 15.0
var cleared = true

var max_wave = 10
var wave_count = 1

func _ready() -> void:
	spawn_point.add_child(angel.instantiate())
	var dialog_inst = dialog.instantiate()
	canvas_layer.add_child(dialog_inst)
	dialog_inst.write_dialog("Hello mortal, I can help you escape this place, you need to survive for 10 waves, here take this power and make sure not to trust anyone here")
	Menumusic.stop()
	Battlemusic.play()
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		canvas_layer_2.add_child(pause_menu.instantiate())
	
	time_label.text = str(int(timer.time_left))
	if cleared == false:
		if current_enemy_count <= 0:
			while enemy_count>current_enemy_count:
				add_enemy_position()
			spawn_enemies(enemy_pos_arr)
			
func start_wave():
	update_wave_counter()
	wave_time += 5.0
	if cleared == true:
		timer.wait_time = wave_time
		timer.start()
		while enemy_count>current_enemy_count:
			add_enemy_position()
			
		if !enemy_pos_arr.is_empty():
			spawn_enemies(enemy_pos_arr)
		wave_count+=1
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
	var dialog_inst = dialog.instantiate()
	timer.stop()
	for child_enemy in enemy_container.get_children():
		child_enemy.free()
	
	if wave_count == 11:
		canvas_layer.add_child(dialog_inst)
		dialog_inst.last_dialog_func()
		spawn_point.add_child(demon.instantiate())
	
	if wave_count == 2:
		canvas_layer.add_child(dialog_inst)
		dialog_inst.write_dialog("Trying to escape hell? Very amusing, you know what here I'll even 'help' you, lets see how far you can go")
	
	if wave_count == 3:
		canvas_layer.add_child(dialog_inst)
		dialog_inst.write_dialog("That devil he cursed you didn't he, dont worry hold out till wave 5 and I'll heal your wounds")
	
	if wave_count == 5:
		canvas_layer.add_child(dialog_inst)
		dialog_inst.write_dialog("As I promised, come let me heal you ")
		
	if wave_count % 2 == 0:
		spawn_point.add_child(demon.instantiate())
	elif wave_count % 2 == 1:
		spawn_point.add_child(angel.instantiate())
	cleared = true
	
func update_wave_counter():
	wave_count_label.text = str(wave_count) + "/" + str(max_wave)
	
