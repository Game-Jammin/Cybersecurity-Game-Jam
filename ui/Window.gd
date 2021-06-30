extends Control
class_name Window

var tween

func _ready():
	rect_scale = Vector2.ZERO
	
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "rect_scale", Vector2(0,0), Vector2(1,1), .1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_get_focus():
	WindowManager.set_focus(name)

func _on_Window_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				_on_get_focus()

func _on_Close_pressed():
	tween.interpolate_property(self, "rect_scale", Vector2(1,1), Vector2(0,0), .1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	tween.connect('tween_all_completed', self, 'close_window')

func close_window():
	queue_free()
