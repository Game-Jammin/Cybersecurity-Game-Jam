extends Control

func _on_Start_pressed():
	get_parent()._on_Close_pressed()
	GameManager.start_game()

func _on_Credits_pressed():
	WindowManager.open_window("Credits")

func _on_Sound_pressed():
	# toggle mute for audio bus 2 (SFX)
	AudioServer.set_bus_mute(2, not AudioServer.is_bus_mute(2))

func _on_Music_pressed():
	# toggle mute for audio bus 1 (Music)
	AudioServer.set_bus_mute(1, not AudioServer.is_bus_mute(1))
