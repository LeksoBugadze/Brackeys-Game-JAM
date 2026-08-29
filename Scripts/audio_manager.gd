extends Node



var config: ConfigFile = ConfigFile.new()
var path: String = "user://game.cfg"

func _ready() -> void:
	# 1. ALWAYS load the audio levels for the speakers when the game starts
	var layout = load("res://default_bus_layout.tres")
	AudioServer.set_bus_layout(layout)
	
	var err = config.load(path)
	if err == OK and not config.get_sections().is_empty():
		var music_db = config.get_value("MUSIC", "Data", 0.0) 
		var sfx_db = config.get_value("SFX", "Data", 0.0)
		
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), music_db)
		var sfx_index = AudioServer.get_bus_index("SFX")
		if sfx_index != -1:
			AudioServer.set_bus_volume_db(sfx_index, sfx_db)
		print("Audio Server initialized from config file.")



func setup_sliders(music_slider: HSlider, sfx_slider: HSlider) -> void:
	var err = config.load(path)
	if err == OK and not config.get_sections().is_empty():
		var music_db = config.get_value("MUSIC", "Data", 0.0) 
		var sfx_db = config.get_value("SFX", "Data", 0.0)
		
		music_slider.value = db_to_linear(music_db)
		sfx_slider.value = db_to_linear(sfx_db)
	
func save_settings(music_value: float, sfx_value: float) -> void:
	config.set_value("MUSIC", "Data", music_value)
	config.set_value("SFX", "Data", sfx_value)
	config.save(path)
	print("Visual slider positions saved successfully!")
