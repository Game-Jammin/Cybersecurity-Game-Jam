extends Control
class_name Window

func _on_get_focus():
	get_parent().move_child(self, get_parent().get_child_count())

func _on_Window_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				_on_get_focus()
