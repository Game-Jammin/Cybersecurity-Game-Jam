extends Control
class_name Window

func _ready():
	rect_scale = Vector2.ZERO
	
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "rect_scale", Vector2(0,0), Vector2(1,1), .1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_get_focus():
	get_parent().move_child(self, get_parent().get_child_count())

func _on_Window_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				_on_get_focus()
