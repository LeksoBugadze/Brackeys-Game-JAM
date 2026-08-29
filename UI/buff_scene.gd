extends Control

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var current_scene:Node3D = get_tree().current_scene

var buff_card = preload("res://UI/buff_card.tscn")
var blood_spell_img = preload("res://UI/Icons/blood_spell.png")
var lightning_spell_img = preload("res://UI/Icons/lightning_spell.png")
var slash_img = preload("res://UI/Icons/slash.png")
var fire_aura_img = preload("res://UI/Icons/fire_aura.png")

var save_title

var title_keys = [
	"Phasing blood","Spellslinger","Thunderclap",
	"Wrath of the skies","Inferno","Wildfire",
	"Sweep","Sharp slash"
	]

var buff_title_dic= {
	"Blood spell":["Phasing blood","Spellslinger"],
	"Lightning spell":["Thunderclap","Wrath of the skies"],
	"Ring of fire":["Inferno","Wildfire"],
	"Slash":["Sweep","Sharp slash"]
}

var buff_dic = {
	"Phasing blood":"-90% cooldown",
	"Spellslinger":"Target all enemies in range",
	"Thunderclap":"+50% damage",
	"Wrath of the skies":"Target all enemies",
	"Inferno":"+50% Range",
	"Wildfire":"+100% damage",
	"Sweep":"Double the range",
	"Sharp slash":"+25% damage"
}

var debuff_dic = {
	"Phasing blood":"-25% damage",
	"Spellslinger":"-80% damage",
	"Thunderclap":"+0.5s cooldown",
	"Wrath of the skies":"+0.5s cooldown",
	"Inferno":"-50% damage",
	"Wildfire":"+50% cooldown",
	"Sweep":"+50% cooldown",
	"Sharp slash":"+50% cooldown"
}

var buff_img_dic = {
	"Phasing blood":blood_spell_img,
	"Spellslinger":blood_spell_img,
	"Thunderclap":lightning_spell_img,
	"Wrath of the skies":lightning_spell_img,
	"Inferno":fire_aura_img,
	"Wildfire":fire_aura_img,
	"Sweep":slash_img,
	"Sharp slash":slash_img
}

var possible_choices = []

func _ready() -> void:
	get_tree().paused = true
	get_possible_choices()
	var choice_count :int = mini(3, possible_choices.size())
	for n in choice_count:
		var buff_card_inst = buff_card.instantiate()
		h_box_container.add_child(buff_card_inst)
		buff_card_inst.upgrade_selected.connect(_quit)
		buff_card_inst.get_choice_info(possible_choices[n],buff_dic[possible_choices[n]], debuff_dic[possible_choices[n]], buff_img_dic[possible_choices[n]])

func _input(event: InputEvent) -> void:
	var mousePosition = get_global_mouse_position()	
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		for node in h_box_container.get_children():
			if not event.pressed:
				if node.get_global_rect().has_point(mousePosition):
					node.add_ability()


func get_possible_choices():
	for keys in player.current_keys:
		for choices in buff_title_dic[keys]:
			if player.current_buff_keys.has(choices):
				pass
			else:
				possible_choices.push_back(choices)
	print(possible_choices)


func _quit():
	get_tree().paused = false
	current_scene.current_enemy_count = 0
	current_scene.start_wave()
	print("triggered")
	queue_free()
