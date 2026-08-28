extends Control

var buff_card = preload("res://UI/buff_card.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer

var choice_count = 3

var title_keys = ["Phan"]



func _ready() -> void:
	get_tree().paused = true
	for n in choice_count:
		var upgrade_card_inst = buff_card.instantiate()
		h_box_container.add_child(upgrade_card_inst)
		#upgrade_card_inst.get_choice_info(title_keys[n],description_dic[title_keys[n]],image_dic[title_keys[n]])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
