extends Node



func _on_button_pressed() -> void:
	ButtonClick.play()
	get_tree().change_scene_to_file("res://UI/start/Start_menu.tscn")
