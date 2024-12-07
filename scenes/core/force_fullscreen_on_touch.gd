extends Node
## Force set fullscreen on click

const FULLSCREEN = DisplayServer.WINDOW_MODE_FULLSCREEN

func _input(event: InputEvent) -> void:
	if OS.get_name() == "Web" and event is InputEventMouse and event.is_pressed():
		if DisplayServer.window_get_mode() != FULLSCREEN:
			DisplayServer.window_set_mode(FULLSCREEN)
