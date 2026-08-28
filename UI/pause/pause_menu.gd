extends Control

@onready var pause_menu: Control = $"."

func _on_buttonResume_pressed() -> void:
	get_tree().paused = false
	pause_menu.visible = false


func _on_buttonMenu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/start/Start_menu.tscn")
