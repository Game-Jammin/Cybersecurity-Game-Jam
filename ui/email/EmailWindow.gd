extends Control

onready var email_line = "res://ui/email/EmailLine.tscn"
onready var email_lines = get_node("EmailList/VBoxContainer")
onready var email_view = get_node("EmailView")

var current_email
var emails = []

func _ready():
	# connected signal for when a new email is added to the list
	EmailManager.connect("new_email", self, "_on_new_email")
	
	update_email_list()

func _on_new_email(new_email):
	add_email_line(new_email)

func add_email_line(new_email):
	var new_email_line = load(email_line).instance()
	new_email_line.set_line_info(new_email)
	new_email_line.connect("pressed", self, "_on_email_line_pressed", [emails.size()])
	emails.append(new_email_line)
	email_lines.add_child(new_email_line)

func remove_email_line(id):
	var email_line = emails[id]
	emails.remove(id)
	email_line.queue_free()

func _on_email_line_pressed(email_line):
	email_view.load_email(emails[email_line])
	switch_view()

func update_email_list():
	for email in EmailManager.current_emails:
		add_email_line(email)

func switch_view():
	$EmailList.visible = !$EmailList.visible
	email_view.visible = !email_view.visible

func _on_Back_pressed():
	switch_view()
