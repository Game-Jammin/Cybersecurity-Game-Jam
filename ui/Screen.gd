extends Control

var mail_window = 'res://ui/email/EmailWindow.tscn'
var game_window = 'res://ui/game/GameWindow.tscn'
var internet_window = 'res://ui/internet/InternetWindow.tscn'

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
	if already_open("EmailWindow"):
		return
	var new_window = load(mail_window).instance()
	
	$Windows.add_child(new_window)

func _on_Game_pressed():
	if already_open("GameWindow"):
		return
	var new_window = load(game_window).instance()
	
	$Windows.add_child(new_window)

func _on_Internet_pressed():
	if already_open("InternetWindow"):
		return
	var new_window = load(internet_window).instance()
	
	$Windows.add_child(new_window)

func already_open(window_name):
	for window in get_tree().get_nodes_in_group("Windows"):
		if window.name == window_name:
			return true
	return false
