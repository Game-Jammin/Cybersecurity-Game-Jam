extends Node

var started
var dialogic

func _on_dialog_end(timeline_name):
	pass
	
func _on_dialogic_signal(signal_name):
	if signal_name == "new_email":
		EmailManager.receive_email()

func start_game():
	EmailManager.load_emails()
	run_dialog("Start")

func run_dialog(name):
	var dialogic = Dialogic.start(name, false)
	add_child(dialogic)
	dialogic.connect("timeline_end", self, '_on_dialog_end')
	dialogic.connect("dialogic_signal", self, '_on_dialogic_signal')
