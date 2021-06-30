extends Control

onready var email_line = "res://ui/email/EmailLine.tscn"
onready var email_lines = get_node("EmailList/ScrollBox/VBoxContainer")

var current_email

func _ready():
	show_email_list()

func show_single_email():
	$EmailList.visible = false
	$EmailView.visible = true

func show_email_list():
	$EmailList.visible = true
	$EmailView.visible = false

func _on_email_line_pressed(email):
	$EmailView.load_email(email)
	show_single_email()
