extends Control

func play_sound(sound_name):
	$Sound.stream = sound_name
	$Sound.play(0)
