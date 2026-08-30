extends Control

@onready var label: Label = $ColorRect2/Label
var last_dialog = false


func write_dialog(dialog:String):
	get_tree().paused = true
	label.text = dialog

func last_dialog_func():
	last_dialog = true
	label.text = "You really though there was an angel in hell trying to help you? how naive can you be, anyways I warned you not to trust anyone here didn't I"

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("dialog_action"):
		if last_dialog == true:
			get_tree().change_scene_to_file("res://UI/ending/end_screen.tscn")
		else:
			get_tree().paused = false
			queue_free()
