extends Control

onready var from_text = get_node("Header/From")
onready var subject_text = get_node("Header/Subject")
onready var body_text = get_node("EmailBody")

func load_email(email):
	email.new = false
	from_text.text = email.from
	subject_text.text = email.subject
	body_text.text = email.body
