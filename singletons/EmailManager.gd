extends Node

signal new_email

onready var email_folder = "res://emails"

var issue_flag = "<flag>"

var emails = []

var current_email = 0

func _ready():
	get_all_email_files()

# Get a list of all email files in the 
func get_all_email_files():
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
	var new_email = json
	new_email.received = false
	new_email.new = true
	new_email.spam = false
	new_email.removed = false
	
	#find <flag> in string and assign to email issues list
	new_email.issues = []
	if issue_flag in new_email.from:
		new_email.issues.append("from")
	if issue_flag in new_email.subject:
		new_email.issues.append("subject")
	
	# remove the <flag> from displayed text
	new_email.from = new_email.from.replace("<flag>", "")
	new_email.subject = new_email.subject.replace("<flag>", "")
	new_email.body = new_email.body.replace("<flag>", "")
	
	emails.append(new_email)

func receive_email():
	if current_email < emails.size():
		emails[current_email].received = true
		current_email = current_email + 1
	
func new_email_num():
	var num = 0
	for email in emails:
		if email.new and email.received:
			num = num + 1
	return num 

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		receive_email()
