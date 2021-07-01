extends Node

onready var windows_node = get_node("/root/Screen/Windows")

func open_window(window_name):
	# return if window is already open
	if windows_node.has_node(window_name + 'Window'):
		set_focus(window_name + 'Window')
		return
	var new_window = load('res://ui/windows/' + window_name + '.tscn').instance()
	windows_node.add_child(new_window)

func set_focus(window_name):
	windows_node.move_child(windows_node.get_node(window_name), windows_node.get_child_count())
