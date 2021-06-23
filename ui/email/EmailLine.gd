extends Button

var email

func update_line():
	visible = email.received
	$HBox/New.visible = email.new
	$HBox/From.text = email.from
	$HBox/Subject.text = email.subject

func _process(delta):
	update_line()
