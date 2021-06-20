extends Button

var from
var subject
var body

func set_line_info(email_info):
	from = email_info.from
	subject = email_info.subject
	body = email_info.body
	
	update_labels()

func update_labels():
	$HBox/From.text = from
	$HBox/Subject.text = subject

func open_email():
	pass
