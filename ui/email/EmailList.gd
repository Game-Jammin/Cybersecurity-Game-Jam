extends ScrollContainer

onready var email_line = "res://ui/email/EmailLine.tscn"
onready var email_list = get_node("VBoxContainer")

func _ready():
	for email in EmailManager.emails:
		var new_email_line = load(email_line).instance()
		new_email_line.email = email
		new_email_line.connect("pressed", get_parent(), "_on_email_line_pressed", [new_email_line.email])
		email_list.add_child(new_email_line)
