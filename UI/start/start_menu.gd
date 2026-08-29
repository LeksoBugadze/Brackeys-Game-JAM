extends Node

func _ready() -> void:
	Battlemusic.stop()
	Menumusic.play()

func _on_buttonstart_pressed() -> void:
	ButtonClick.play()
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_buttonsettings_pressed() -> void:
	ButtonClick.play()
	pass


func _on_buttonquit_pressed() -> void:
	ButtonClick.play()
	await ButtonClick.finished
	get_tree().quit()
