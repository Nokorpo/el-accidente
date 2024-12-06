extends PanelContainer

func _is_screen_in_portrait() -> bool:
	var screen_size: Vector2 = DisplayServer.screen_get_size()
	return (screen_size.x/screen_size.y) < 1

func _process(_delta: float) -> void:
	if _is_screen_in_portrait():
		show()
	elif visible:
		hide()
