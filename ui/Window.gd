extends Control
class_name Window

export (String) var window_title

var dragging = false
var draggaing_start_position = null

func _ready():
	$TitleBar/Label.text = window_title

func _process(delta):
	if dragging:
		set_position(get_global_mouse_position() - draggaing_start_position)

func _on_TitleBar_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				_on_get_focus()
				dragging = true
				draggaing_start_position = get_global_mouse_position() - get_position()
			else:
				dragging = false

func _on_Close_pressed():
	queue_free()

func _on_get_focus():
	get_parent().move_child(self, get_parent().get_child_count())

func _on_Window_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				_on_get_focus()
