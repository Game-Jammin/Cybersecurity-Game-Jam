extends Panel

var dragging = false
var draggaing_start_position = null

func _ready():
	rect_scale = Vector2.ZERO
	var screen_size = get_viewport().get_visible_rect().size
	var pos_x = rand_range(0, screen_size.x)
	var pos_y = rand_range(0, screen_size.y - 100)
	set_global_position(Vector2(pos_x, pos_y))
	
	$Tween.interpolate_property(self, "rect_scale", Vector2(0,0), Vector2(1,1), .1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Close_pressed():
	$Tween.interpolate_property(self, "rect_scale", Vector2(1,1), Vector2(0,0), .1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	$Tween.connect('tween_all_completed', self, 'close_window')

func close_window():
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
