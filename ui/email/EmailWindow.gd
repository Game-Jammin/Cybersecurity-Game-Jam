extends Control

func _ready():
	show_email_list()

func show_single_email():
	$EmailList.visible = false
	$EmailView.visible = true

func show_email_list():
	GameManager.email_list()
	$EmailList.visible = true
	$EmailView.visible = false

func _on_email_line_pressed(email):
	$EmailView.load_email(email)
	show_single_email()
