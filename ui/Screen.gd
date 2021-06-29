extends Control

func _ready():
	# connect the buttons
	for button in $Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.name])

func _on_Button_pressed(button_name):
	# return if window is already open
	if $Windows.has_node(button_name):
		return
	var new_window = load('res://ui/windows/' + button_name + '.tscn').instance()
	$Windows.add_child(new_window)
