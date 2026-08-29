extends Panel

signal upgrade_selected

@onready var parent_node: Control = $".."
@onready var title: Label = $VBoxContainer/MarginContainer3/title
@onready var texture_rect: TextureRect = $VBoxContainer/MarginContainer/TextureRect
@onready var description: Label = $VBoxContainer/MarginContainer2/description
@onready var margin_container_4: MarginContainer = $VBoxContainer/MarginContainer4
@onready var debuff: Label = $VBoxContainer/MarginContainer4/debuff
@onready var player :CharacterBody3D = get_tree().get_nodes_in_group("player")[0]

var title_var

var phasing_blood= preload("res://Scripts/Buffs/Blood_Spell/phasing_blood.tscn")
var spellslinger = preload("res://Scripts/Buffs/Blood_Spell/spellslinger.tscn")
var thunderclap = preload("res://Scripts/Buffs/Lightning_Spell/thunderclap_buff.tscn")
var wrath_of_the_skies = preload("res://Scripts/Buffs/Lightning_Spell/wrath_of_the_skies_buff.tscn")
var inferno = preload("res://Scripts/Buffs/Player_Aura/inferno.tscn")
var wildfire = preload("res://Scripts/Buffs/Player_Aura/wildfire.tscn")
var sweep = preload("res://Scripts/Buffs/slash_buffs/sweep.tscn")
var sharp_slash = preload("res://Scripts/Buffs/slash_buffs/sharp_slash.tscn")

var title_keys = [
	"Phasing blood","Spellslinger","Thunderclap",
	"Wrath of the skies","Inferno","Wildfire",
	"Sweep","Sharp slash"
	]

var ability_name={
	"Phasing blood":"Blood spell",
	"Spellslinger":"Blood spell",
	"Thunderclap":"Lightning spell",
	"Wrath of the skies":"Lightning spell",
	"Inferno":"Ring of fire",
	"Wildfire":"Ring of fire",
	"Sweep":"Slash",
	"Sharp slash":"Slash"
}

var parent_ability_name={
	"Phasing blood":"BloodSpell",
	"Spellslinger":"BloodSpell",
	"Thunderclap":"lightning_strike_ability",
	"Wrath of the skies":"lightning_strike_ability",
	"Inferno":"Player_aura",
	"Wildfire":"Player_aura",
	"Sweep":"player_slash",
	"Sharp slash":"player_slash"
}

var func_dic = {
	"Phasing blood":phasing_blood,
	"Spellslinger":spellslinger,
	"Thunderclap":thunderclap,
	"Wrath of the skies":wrath_of_the_skies,
	"Inferno":inferno,
	"Wildfire":wildfire,
	"Sweep":sweep,
	"Sharp slash":sharp_slash
}

func get_choice_info(title_arg:String,description_arg:String, debuff_arg:String, texture:Texture2D):
	title_var = title_arg
	title.text = title_arg
	description.text = description_arg
	texture_rect.texture = texture
	debuff.text = debuff_arg

func add_ability():
	##find the ability node inside the player
	var ability_node = player.get_node_or_null(parent_ability_name[title_var])
	##add buff to that ability node
	ability_node.add_child(func_dic[title_var].instantiate())
	##delete buff from possible choices
	player.current_buff_keys.push_back(title_var)
	margin_container_4.visible = !margin_container_4.visible
	await get_tree().create_timer(1.5).timeout
	upgrade_selected.emit()
	
