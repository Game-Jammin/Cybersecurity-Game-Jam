extends ScrollContainer

onready var email_line = "res://ui/email/EmailLine.tscn"

var email_lines = []

func _ready():
	# connected signal for when a new email is added to the list
	EmailManager.connect("new_email", self, "_on_new_email")
	
	update_list()

func _on_new_email(new_email):
	new_email(new_email)

func new_email(new_email):
	var new_email_line = load(email_line).instance()
	
	new_email_line.set_line_info(new_email)
	
	email_lines.append(new_email_line)
	$VBoxContainer.add_child(new_email_line)

func remove_email(id):
	var email_line = email_lines[id]
	email_lines.remove(id)
	email_line.queue_free()

func update_list():
	for email in EmailManager.emails:
		new_email(email)
	
func clear_list():
	pass
