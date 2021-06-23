extends ColorRect

func _process(delta):
	visible = EmailManager.new_email_num() > 0
	if new_email_num() > 0:
		$Label.text = str(EmailManager.new_email_num())

func new_email_num():
	var num = 0
	for email in EmailManager.emails:
		if email.new and email.received:
			num = num + 1
	return num 
