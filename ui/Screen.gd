extends Control

func _ready():
	# Open the menu window
	WindowManager.open_window("Menu")
	
	# connect the buttons
	for button in $Buttons.get_children():
		button.connect("pressed", WindowManager, "open_window", [button.name])
