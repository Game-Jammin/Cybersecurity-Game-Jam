extends Control

onready var from_text = get_node("HeaderInfo/From")
onready var subject_text = get_node("HeaderInfo/Subject")
onready var body_text = get_node("EmailBody/Container/BodyText")

var selected = []

func load_email(email):
	email.new = false
	from_text.text = email.from
	subject_text.text = email.subject
	body_text.text = email.body
	print (email.issues)

func _process(delta):
	$Options/Delete.disabled = selected.size() == 0
	
	update_selected_ui()

func _on_From_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				if "from" in selected:
					selected.remove(selected.bsearch("from"))
				else:
					selected.append("from")
				print (selected)

func _on_Subject_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				if "subject" in selected:
					selected.remove(selected.bsearch("subject"))
				else:
					selected.append("subject")
				print (selected)

func update_selected_ui():
	# from selected
	from_text.get_node("Select").visible = "from" in selected
	
	# subject selected
	subject_text.get_node("Select").visible = "subject" in selected
