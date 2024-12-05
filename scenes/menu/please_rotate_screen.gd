extends PanelContainer

func _is_screen_in_portrait() -> bool:
	var size: Vector2 = DisplayServer.screen_get_size()
	return (size.x/size.y) < 1

func _process(delta: float) -> void:
	if _is_screen_in_portrait():
		show()
	elif visible:
		hide()
