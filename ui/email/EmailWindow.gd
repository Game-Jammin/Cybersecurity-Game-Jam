extends Control

onready var email_line = "res://ui/email/EmailLine.tscn"
onready var email_lines = get_node("EmailList/VBoxContainer")
onready var email_view = get_node("EmailView")

var current_email

func _ready():
	create_email_list()

func create_email_list():
	for email in EmailManager.emails:
		add_email_line(email)

func add_email_line(new_email):
	var new_email_line = load(email_line).instance()
	new_email_line.email = new_email
	new_email_line.connect("pressed", self, "_on_email_line_pressed", [new_email_line.email])
	email_lines.add_child(new_email_line)

func _on_email_line_pressed(email):
	email_view.load_email(email)
	show_single_email()

func show_single_email():
	$EmailList.visible = false
	email_view.visible = true

func show_email_list():
	$EmailList.visible = true
	email_view.visible = false

func _on_Back_pressed():
	show_email_list()

func _on_Spam_pressed():
	pass # Replace with function body.

func _on_Delete_pressed():
	show_email_list()
