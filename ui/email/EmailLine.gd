extends Button

var email

func update_line():
	#visible = (email.received and !email.flagged)
	if email.new:
		$HBox/New.text = '*'
	else:
		$HBox/New.text = ''
	$HBox/From.text = email.from
	$HBox/Subject.text = email.subject

func _process(delta):
	update_line()
