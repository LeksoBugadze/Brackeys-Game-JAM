extends Panel

signal upgrade_selected

@onready var texture_rect: TextureRect = $VBoxContainer/MarginContainer/TextureRect
@onready var description: Label = $VBoxContainer/MarginContainer2/description
@onready var title: Label = $VBoxContainer/MarginContainer3/title

@onready var player :CharacterBody3D = get_tree().get_nodes_in_group("player")[0]

var blood_spell = preload("res://Scenes/blood_spell_ability.tscn")
var lightning_spell = preload("res://Scenes/lightning_strike_ability.tscn")
var slash = preload("res://Slash_VFX/slash_ability.tscn")
var fire_aura = preload("res://Fire_Aura_VFX/player_aura.tscn")

var title_var

var func_dic = {
	"Blood spell" : blood_spell,
	"Lightning spell" : lightning_spell,
	"Slash" : slash,
	"Ring of fire" : fire_aura
}

func get_choice_info(title_arg:String,description_arg:String, texture:Texture2D):
	title_var = title_arg
	title.text = title_arg
	description.text = description_arg
	texture_rect.texture = texture


func add_ability():
	player.add_node(func_dic[title_var].instantiate())
	player.current_keys.push_back(title_var)
	print(player.current_keys)
	upgrade_selected.emit()
	
