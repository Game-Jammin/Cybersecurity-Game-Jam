extends Node

var started
var dialogic

var time = 0
var wrong = 0

func _ready():
	randomize()
	EmailManager.connect('email_flagged', self, '_on_email_flag')

func _process(delta):
	time = time + delta

func _on_dialog_end(timeline_name):
	pass
	
func _on_dialogic_signal(signal_name):
	if signal_name == "new_email":
		EmailManager.receive_email()

func start_game():
	time = 0
	wrong = 0
	EmailManager.load_emails()
	run_dialog("Start")

func run_dialog(name):
	var dialogic = Dialogic.start(name, false)
	add_child(dialogic)
	dialogic.connect("timeline_end", self, '_on_dialog_end')
	dialogic.connect("dialogic_signal", self, '_on_dialogic_signal')

func _on_email_flag(correct):
	if not correct:
		wrong = wrong + 1
