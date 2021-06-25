extends Control

func _ready():
	pass
	#var new_dialog = Dialogic.start("Start", false)
	#add_child(new_dialog)
	#new_dialog.connect("timeline_end", self, '_on_dialog_end')
	#new_dialog.connect("dialogic_signal", self, '_on_dialogic_signal')
	
func _on_dialog_end(timeline_name):
	pass
	
func _on_dialogic_signal(signal_name):
	if signal_name == "new_email":
		EmailManager.receive_email()

func _on_Email_pressed():
	$Windows/EmailWindow.visible = true

func _on_Game_pressed():
	$Windows/GameWindow.visible = true

func _on_Internet_pressed():
	$Windows/InternetWindow.visible = true

func _on_Notes_pressed():
	$Windows/NotesWindow.visible = true
