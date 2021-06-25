extends ColorRect
class_name TitleBar

export (String) var window_name

var dragging = false
var draggaing_start_position = null

func _ready():
	$Label.text = window_name

func _process(delta):
	if dragging:
		get_parent().set_position(get_global_mouse_position() - draggaing_start_position)

func _on_TitleBar_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				get_parent()._on_get_focus()
				dragging = true
				draggaing_start_position = get_global_mouse_position() - get_parent().get_position()
			else:
				dragging = false

func _on_Close_pressed():
	get_parent().visible = false
