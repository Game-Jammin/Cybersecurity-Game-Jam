extends Control

func click():
	$Click.play()

func _input(event):
	if event.is_action_released("mouse_click"):
		$MouseUp.play()
	if event.is_action_pressed("mouse_click"):
		$MouseDown.play()
