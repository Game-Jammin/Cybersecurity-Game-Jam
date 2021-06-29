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

	clear_body()
	
	fill_body(email.body)

func clear_body():
	for line in body_text.get_children():
		line.queue_free()

func fill_body(body):
	var num = 0
	for line in body.split('\n'):
		var new_line = Label.new()
		new_line.set_text(line)
		new_line.set_mouse_filter(MOUSE_FILTER_STOP)
		new_line.name = str(num)
		# Add input event listener to new object
		new_line.connect("gui_input", self, "_on_gui_input", [num])
		body_text.add_child(new_line)
		num = num + 1

func _process(delta):
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
		selected.remove(selected.bsearch(element))
	else:
		selected.append(element)

func update_selected_ui():
	# from selected
	from.get_node("Select").visible = "from" in selected
	
	# subject selected
	subject.get_node("Select").visible = "subject" in selected
