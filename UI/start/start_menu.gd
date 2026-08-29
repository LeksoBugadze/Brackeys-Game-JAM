extends Node

var config: ConfigFile = ConfigFile.new()
var path: String = "user://game.cfg"

var music_volume: float = 0.0
var sfx_volume: float = 0.0


func _ready() -> void:
	Battlemusic.stop()
	Menumusic.play()

func _on_buttonstart_pressed() -> void:
	ButtonClick.play()
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_buttonsettings_pressed() -> void:
	ButtonClick.play()
	get_tree().change_scene_to_file("res://UI/settings/settings_menu.tscn")

	


func _on_buttonquit_pressed() -> void:
	ButtonClick.play()
	await ButtonClick.finished
	get_tree().quit()
