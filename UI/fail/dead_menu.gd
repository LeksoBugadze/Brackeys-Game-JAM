extends Control

func _ready() -> void:
	Battlemusic.stop()
	Menumusic.play()

func _on_buttonrestart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
