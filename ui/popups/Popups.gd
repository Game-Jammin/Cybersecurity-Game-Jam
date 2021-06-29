extends Control

var popup = "res://ui/popups/Popup.tscn"

export (bool) var running = false
export (int) var max_popups = 5
export (float) var current_cooldown = 3

func _process(_delta):
	visible = $Container.get_child_count() > 0
	
	if $Container.get_child_count() <= max_popups and $Timer.is_stopped() and running:
		$Timer.start(current_cooldown)

func new_popup():
	var new_popup = load(popup).instance()
	$Container.add_child(new_popup)

func _on_Timer_timeout():
	new_popup()
