extends Control

func _process(_delta):
	visible = get_parent().name.to_lower() in get_tree().get_root().find_node('EmailView', true, false).selected
