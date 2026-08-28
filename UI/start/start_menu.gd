extends Node


func _on_buttonstart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_buttonsettings_pressed() -> void:
	pass


func _on_buttonquit_pressed() -> void:
	get_tree().quit()
