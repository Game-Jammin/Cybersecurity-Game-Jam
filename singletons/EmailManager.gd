extends Node

signal email_flagged
onready var email_folder = "res://emails"

var issue_flag = "<flag>"

var emails
var email = {'received': false, 'new': true, 'flagged': 'Pending',
 'from': '', 'subject': '', 'body_lines': [], 'attachments': [], 'issues': []}

var current_email

func _ready():
	load_emails()

# Get a list of all email files in the 
func load_emails():
	emails = []
	current_email = 0
	var dir = Directory.new()
	dir.open(email_folder)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			read_email_file(email_folder + '/' + file)
	dir.list_dir_end()

# Read the json file into the emails dict
func read_email_file(file_path):
	var file = File.new()  
	file.open(file_path, File.READ)  
	var text_json = file.get_as_text()
	file.close()
	var result_json = JSON.parse(text_json)
	if result_json.error == OK:  # If parse OK
		generate_new_email(result_json.result)

# parse the json data and genete and email object
func generate_new_email(json):
	var new_email = email.duplicate(true)
	
	# Test if from and subject have issue flag
	if issue_flag in json.from:
		new_email.issues.append("from")
	if issue_flag in json.subject:
		new_email.issues.append("subject")
	
	# Remove flags and set from and subject
	new_email.from = json.from.replace("<flag>", "")
	new_email.subject = json.subject.replace("<flag>", "")
	
	# Loop though body lines and remove flags and add to issue list
	var line_number = 0
	for line in json.body.split('\n'):
		if issue_flag in line:
			new_email.issues.append('line' + str(line_number))
		new_email.body_lines.append(line.replace("<flag>", ""))
		line_number = line_number + 1
	
	# Loop through email attachemnts, removing flags and adding to issue list
	var attachemnt_number = 0
	for attachment in json.attachments:
		if issue_flag in attachment:
			new_email.issues.append('attachment' + str(attachemnt_number))
		new_email.attachments.append(attachment.replace("<flag>", ""))
		attachemnt_number = attachemnt_number + 1
	
	emails.append(new_email)

func receive_email():
	if current_email < emails.size():
		emails[current_email].received = true
		current_email = current_email + 1

func flagged_all_email():
	for email in emails:
		if email.flagged == "Pending":
			return false
	return true

func new_email_num():
	var num = 0
	for email in emails:
		if email.new and email.received:
			num = num + 1
	return num 

func flag_email(email, status, selected):
	email.flagged = status
	var correct = true
	
	for issue in email.issues:
		if not issue in selected:
			correct = false
	
	for select in selected:
		if not select in email.issues:
			correct = false
	
	emit_signal("email_flagged", status, correct)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		receive_email()
