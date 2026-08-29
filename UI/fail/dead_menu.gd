extends Control

func _ready() -> void:
	Battlemusic.stop()
	Menumusic.play()

func _on_buttonrestart_pressed() -> void:
	#this will not work:(*
	ButtonClick.play()
	await ButtonClick.finished #await the sound then go another scene
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
