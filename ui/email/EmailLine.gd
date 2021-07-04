extends Button

var email

func update_line():
	visible = (email.received)
	$HBox/Flagged.text = email.flagged
	match email.flagged:
		"Pending":
			$HBox/Flagged.set("custom_colors/font_color", Color(0.0,0.0,0.0,1.0))
		"Approved":
			$HBox/Flagged.set("custom_colors/font_color", Color(0.5,0.8,0.5,1.0))
		"Denied":
			$HBox/Flagged.set("custom_colors/font_color", Color(1.0,0.5,0.5,1.0))
	
	$HBox/From.text = email.from
	$HBox/Subject.text = email.subject
	
	if email.new:
		$HBox/From.text
		$HBox/Subject.text

func _process(delta):
	update_line()
