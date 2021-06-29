extends Control

func _ready():
	# connect the buttons
	for button in $Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.name])
	#var new_dialog = Dialogic.start("Start", false)
	#add_child(new_dialog)
	#new_dialog.connect("timeline_end", self, '_on_dialog_end')
	#new_dialog.connect("dialogic_signal", self, '_on_dialogic_signal')
	
func _on_dialog_end(timeline_name):
	pass
	
func _on_dialogic_signal(signal_name):
	if signal_name == "new_email":
		EmailManager.receive_email()

func _on_Button_pressed(button_name):
	# return if window is already open
	if $Windows.has_node(button_name):
		return
	var new_window = load('res://ui/windows/' + button_name + '.tscn').instance()
	$Windows.add_child(new_window)
