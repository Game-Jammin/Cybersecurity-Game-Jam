extends Panel

var dragging = false
var draggaing_start_position = null

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	var pos_x = rand_range(0, screen_size.x)
	var pos_y = rand_range(0, screen_size.y)
	set_global_position(Vector2(pos_x, pos_y))

func _on_Close_pressed():
	queue_free()

func _process(delta):
	if dragging:
		set_position(get_global_mouse_position() - draggaing_start_position)

func _on_Popup_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				_on_get_focus()
				dragging = true
				draggaing_start_position = get_global_mouse_position() - get_position()
			else:
				dragging = false

func _on_get_focus():
	get_parent().move_child(self, get_parent().get_child_count())
