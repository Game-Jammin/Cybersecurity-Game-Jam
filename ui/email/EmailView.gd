extends Control

onready var attachment_prefab = "res://ui/email/Attachment.tscn"
onready var body_line_prefab = "res://ui/email/BodyLine.tscn"

onready var from = get_node("HeaderInfo/From")
onready var subject = get_node("HeaderInfo/Subject")
onready var body_text_container = get_node("EmailBodyBackground/EmailBody/Container/TextLines")
onready var attachments_container = get_node("EmailBodyBackground/EmailBody/Container/Attachments")

onready var accept_button = get_node("Options/Accept")
onready var deny_button = get_node("Options/Deny")

var current_email
var selected = []

func _ready():
	from.connect("gui_input", self, "_on_gui_input", ['from'])
	subject.connect("gui_input", self, "_on_gui_input", ['subject'])

func load_email(email):
	current_email = email
	selected = []
	email.new = false
	from.get_node("Text").text = email.from
	subject.get_node("Text").text = email.subject
	
	deny_button.visible = not email.flagged
	accept_button.visible = not email.flagged
	
	fill_body_lines(email.body_lines)
	fill_email_attachments(email.attachments)


func fill_body_lines(body_lines):
	for line in body_text_container.get_children():
		line.queue_free()
	
	var line_number = 0
	for line in body_lines:
		var new_line = load(body_line_prefab).instance()
		new_line.get_node("Text").set_text(line)
		new_line.set_mouse_filter(MOUSE_FILTER_STOP)
		new_line.name = 'line' + str(line_number)
		# Add input event listener to new object
		new_line.connect("gui_input", self, "_on_gui_input", [new_line.name])
		body_text_container.add_child(new_line)
		line_number = line_number + 1

func fill_email_attachments(attachments):
	$EmailBodyBackground/EmailBody/Container/AttachmentHeader.visible = attachments.size() > 0
	
	for attachment in attachments_container.get_children():
		attachment.queue_free()
	
	var attachment_number = 0
	for attachment in attachments:
		var new_attachment = load(attachment_prefab).instance()
		new_attachment.get_node("Text").set_text(attachment)
		new_attachment.name = 'attachment' + str(attachment_number)
		# Add input event listener to new object
		new_attachment.connect("gui_input", self, "_on_gui_input", [new_attachment.name])
		attachments_container.add_child(new_attachment)
		attachment_number = attachment_number + 1

func _process(_delta):
	deny_button.disabled = selected.size() == 0

func _on_gui_input(event, element):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				select(element)

func select(element):
	if element in selected:
		selected.erase(element)
	else:
		selected.append(element)

func _on_Back_pressed():
	get_parent().show_email_list()

func _on_Deny_pressed():
	EmailManager.flag_email(current_email, selected)
	get_parent().show_email_list()

func _on_Accept_pressed():
	EmailManager.flag_email(current_email, [])
	get_parent().show_email_list()
