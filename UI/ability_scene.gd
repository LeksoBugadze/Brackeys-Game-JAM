extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var current_scene:Node3D = get_tree().current_scene
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var spawn_point = get_tree().current_scene.get_node("spawn_point").get_children()[0]

var upgrade_card = preload("res://UI/ability_card.tscn")

var blood_spell_img = preload("res://UI/Icons/blood_spell.png")
var lightning_spell_img = preload("res://UI/Icons/lightning_spell.png")
var slash_img = preload("res://UI/Icons/slash.png")
var fire_aura_img = preload("res://UI/Icons/fire_aura.png")

var title_keys = ["Blood spell", "Lightning spell", "Slash", "Ring of fire"]

var description_dic = {
	"Blood spell":"Shoots projectile at enemies dealing moderate amount of damage",
	"Lightning spell" : "Shoots lightning projectile at a random enemy with infinite range",
	"Slash" : "Creates a melee attack in front of you",
	"Ring of fire" : "Creates a ring of fire around you that deals small constant damage to enemies nearby"
}

var ability_name={
	"Blood spell":"BloodSpell",
	"Lightning spell":"lightning_strike_ability",
	"Slash":"player_slash",
	"Ring of fire":"Player_aura"
}

var image_dic ={
	"Blood spell":blood_spell_img,
	"Lightning spell" : lightning_spell_img,
	"Slash" : slash_img,
	"Ring of fire": fire_aura_img
}

var choice_count = 4

func _ready() -> void:
	get_tree().paused = true
	for n in choice_count:
		if !player.get_node_or_null(ability_name[title_keys[n]]):
			var upgrade_card_inst = upgrade_card.instantiate()
			h_box_container.add_child(upgrade_card_inst)
			upgrade_card_inst.upgrade_selected.connect(_quit)
			upgrade_card_inst.get_choice_info(title_keys[n],description_dic[title_keys[n]],image_dic[title_keys[n]])
	
	if h_box_container.get_children().is_empty():
		_quit()

func _input(event: InputEvent) -> void:
	var mousePosition = get_global_mouse_position()	
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("pressed the left click")
		UpgradeButtonClick.play()
		for node in h_box_container.get_children():
			if node.get_global_rect().has_point(mousePosition):
				node.add_ability()

func _quit():
	get_tree().paused = false
	spawn_point.queue_free()
	current_scene.current_enemy_count = 0
	current_scene.start_wave()
	print("triggered")
	queue_free()
