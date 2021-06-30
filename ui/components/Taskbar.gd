extends Control

var buttons = []

func _process(_delta):
	
	for button in buttons:
		if not get_node("/root/Screen/Windows").has_node(button.name):
			buttons.erase(button)
			button.queue_free()
	
	for window in get_node("/root/Screen/Windows").get_children():
		if not $OpenWindows.has_node(window.name):
			# add new taskbar button
			var new_button = Button.new()
			new_button.text = window.name.replace("Window",'')
			new_button.name = window.name
			new_button.rect_min_size = Vector2(100,0)
			new_button.connect('pressed', WindowManager, 'set_focus', [window.name])
			$OpenWindows.add_child(new_button)
			buttons.append(new_button)
