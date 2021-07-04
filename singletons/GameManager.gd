extends Node

var started
var dialogic

var time = 0
var wrong = 0

var email_list_opened = false
var email_view_opened = false

func _ready():
	randomize()
	EmailManager.connect('email_flagged', self, '_on_email_flag')

func _process(delta):
	time = time + delta
	
	if EmailManager.flagged_all_email() and started:
		started = false
		run_dialog("Outro")

func _on_dialog_end(timeline_name):
	print (timeline_name)
	if timeline_name == "Outro.json":
		WindowManager.open_window("Outro")
	
func _on_dialogic_signal(signal_name):
	if signal_name == "new_email":
		EmailManager.receive_email()

func reset():
	email_list_opened = false
	email_view_opened = false
	time = 0
	wrong = 0
	started = true

func start_game():
	started = true
	reset()
	EmailManager.load_emails()
	run_dialog("Intro")

func end_game():
	run_dialog("Outro")

func run_dialog(name):
	var dialogic = Dialogic.start(name, false)
	add_child(dialogic)
	dialogic.connect("timeline_end", self, '_on_dialog_end')
	dialogic.connect("dialogic_signal", self, '_on_dialogic_signal')

func _on_email_flag(status, correct):
	if status == "Approved" and not correct:
		wrong = wrong + 1
		# Start dialog with hacker
	if status == "Denied" and not correct:
		# Start dialog with email admin
		pass
	else:
		# First time start dialog with email admin congratuating you on the correct answer
		pass

func email_list():
	if not email_list_opened and started:
		email_list_opened = true
		run_dialog("EmailList")

func email_view():
	if not email_view_opened and started:
		email_view_opened = true
		run_dialog("EmailView")
