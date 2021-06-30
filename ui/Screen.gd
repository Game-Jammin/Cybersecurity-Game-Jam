extends Control

func _ready():
	# connect the buttons
	for button in $Buttons.get_children():
		button.connect("pressed", WindowManager, "open_window", [button.name])
