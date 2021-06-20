extends ColorRect

func _process(delta):
	visible = EmailManager.new_email_num() > 0
	if EmailManager.new_email_num() > 0:
		$Label.text = str(EmailManager.new_email_num())
