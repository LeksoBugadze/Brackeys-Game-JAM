extends Node3D

@onready var shooting_range: Area3D = $Range
@onready var cooldown: Timer = $cooldown 

var blood_spell_vfx = preload("res://Fireball_VFX/blood_spell.tscn")
var spellslinger_buff = preload("res://Scripts/Buffs/Blood_Spell/spellslinger.tscn")
var phasing_blood_buff = preload("res://Scripts/Buffs/Blood_Spell/phasing_blood.tscn")

var hit_all_targets = false
var can_shoot = false
var damage : float = 50.0

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("buff_n_1"):
		add_child(spellslinger_buff.instantiate())
	
	if Input.is_action_just_pressed("buff_n_2"):
		add_child(phasing_blood_buff.instantiate())
	

func _on_timer_timeout() -> void:
	can_shoot = true
	for body in shooting_range.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			if can_shoot || hit_all_targets:
				can_shoot = false
				look_at(body.global_position,Vector3.UP)
				var projectile = shoot()
				projectile.collided.connect(_on_proj_hit)


func shoot()->CharacterBody3D:
	var blood_spell_inst = blood_spell_vfx.instantiate()
	get_tree().current_scene.add_child(blood_spell_inst)
	blood_spell_inst.global_transform = global_transform
	
	return blood_spell_inst

func _on_proj_hit(hit_node):
	if hit_node.has_method("take_damage"):
		hit_node.take_damage(damage)
