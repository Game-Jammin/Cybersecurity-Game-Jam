extends Node

signal new_email

onready var email_folder = "res://emails"

var emails = []
var displayed_emails = []

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
		var new_email = result_json.result
		new_email.new = true
		emails.append(new_email)

func new_email():
	emit_signal("new_email")
	
func remove_email():
	pass