extends Control

onready var from = get_node("HeaderInfo/From")
onready var subject = get_node("HeaderInfo/Subject")
onready var body_text = get_node("EmailBody/Container/TextLines")

var selected = []

func _ready():
	from.connect("gui_input", self, "_on_gui_input", ['from'])
	subject.connect("gui_input", self, "_on_gui_input", ['subject'])

func load_email(email):
	selected = []
	email.new = false
	from.get_node("Text").text = email.from
	subject.get_node("Text").text = email.subject

	clear_body_lines()
	
	fill_body_lines(email.body_lines)

func clear_body_lines():
	for line in body_text.get_children():
		line.queue_free()

func fill_body_lines(body_lines):
	var line_number = 0
	for line in body_lines:
		var new_line = Label.new()
		new_line.set_text(line)
		new_line.set_mouse_filter(MOUSE_FILTER_STOP)
		new_line.name = str(line_number)
		# Add input event listener to new object
		new_line.connect("gui_input", self, "_on_gui_input", [line_number])
		body_text.add_child(new_line)
		line_number = line_number + 1

func _process(_delta):
	$Options/Delete.disabled = selected.size() == 0
	update_selected_ui()

func _on_gui_input(event, element):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				select(element)
				print (selected)

func select(element):
	if element in selected:
		selected.erase(element)
	else:
		selected.append(element)

func update_selected_ui():
	# from selected
	from.get_node("Select").visible = "from" in selected
	
	# subject selected
	subject.get_node("Select").visible = "subject" in selected

func _on_Back_pressed():
	get_parent().show_email_list()

func _on_Delete_pressed():
	get_parent().show_email_list()
