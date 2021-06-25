extends Control
class_name ResizeControls

var following = false
var mouse_offset
var window_position
var window_size
var distance_to_edge = 2.5

var scale_x = false
var scale_y = false

func _on_VerticalScale_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				mouse_offset = get_global_mouse_position()
				window_position = get_parent().get_position()
				window_size = get_parent().rect_size
				following = true
				scale_y = true
			else:
				following = false
				scale_y = false

func _on_HorizonalScale_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				mouse_offset = get_global_mouse_position()
				window_position = get_parent().get_position()
				window_size = get_parent().rect_size
				following = true
				scale_x = true
			else:
				following = false
				scale_x = false

func _on_Scale_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				mouse_offset = get_global_mouse_position()
				window_position = get_parent().get_position()
				window_size = get_parent().rect_size
				following = true
				scale_x = true
				scale_y = true
			else:
				following = false
				scale_x = false
				scale_y = false

func _process(delta):
	if following:
		get_parent()._on_get_focus()
		if (scale_y):
			get_parent().rect_size.y = window_size.y + (get_global_mouse_position().y - mouse_offset.y)
		
		if (scale_x):
			get_parent().rect_size.x = window_size.x + (get_global_mouse_position().x - mouse_offset.x)
