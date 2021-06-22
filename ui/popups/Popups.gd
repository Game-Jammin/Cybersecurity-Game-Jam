extends Control

var popup = "res://ui/popups/Popup.tscn"

func _process(delta):
	visible = get_child_count() > 0

func new_popup():
	var new_popup = load(popup).instance()
	
	add_child(new_popup)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		new_popup()
