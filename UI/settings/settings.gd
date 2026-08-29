extends Node


@onready var music: HSlider = $VBoxContainer/music
@onready var sfx: HSlider = $VBoxContainer/sfx

var config: ConfigFile = ConfigFile.new()
var path: String = "user://game.cfg"



func _ready() -> void:
	AudioManager.setup_sliders(music, sfx)	

	
	

func _on_music_value_changed(value: float) -> void:
	var db_value = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), db_value)


func _on_sfx_value_changed(value: float) -> void:
	var db_value = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db_value)


func _on_savebutton_pressed() -> void:
	AudioManager.save_settings(music.value, sfx.value)
	ButtonClick.play()
	get_tree().change_scene_to_file("res://UI/start/Start_menu.tscn")
