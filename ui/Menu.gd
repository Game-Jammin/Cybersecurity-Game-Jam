extends Control

func _on_Start_pressed():
	get_parent()._on_Close_pressed()
	GameManager.start_game()
