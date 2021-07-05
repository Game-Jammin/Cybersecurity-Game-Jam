extends Control

var popup_folder = "res://ui/popups/variants"

export (int) var max_popups = 5
export (float) var current_cooldown = 3

var popups = []

func _ready():
	popups = []
	var dir = Directory.new()
	dir.open(popup_folder)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			popups.append(popup_folder + '/' + file)
	dir.list_dir_end()

func _process(_delta):
	
	visible = $Container.get_child_count() > 0
	
	if $Container.get_child_count() <= max_popups and $Timer.is_stopped() and GameManager.hacked:
		$Timer.start(current_cooldown)

func new_popup():
	var new_popup = load(popups[randi() % popups.size()]).instance()
	$Container.add_child(new_popup)

func _on_Timer_timeout():
	new_popup()
