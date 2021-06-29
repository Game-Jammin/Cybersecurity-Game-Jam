extends NinePatchRect

func _process(_delta):
	visible = get_parent().name in get_tree().get_root().find_node('EmailView', true, false).selected
