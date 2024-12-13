extends CanvasLayer

var _current_orientation := DisplayServer.ScreenOrientation.SCREEN_LANDSCAPE

func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	var new_orientation := _get_screen_orientation()
	if new_orientation != _current_orientation:
		_current_orientation = new_orientation
		if _current_orientation == DisplayServer.ScreenOrientation.SCREEN_PORTRAIT:
			_show_screen()
		else:
			_hide_screen()

func _show_screen() -> void:
	show()
	$PleaseRotateScreen/VBoxContainer/Ignore.hide()
	%TimeToRotate.start()
	EventBus.request_pause.emit()

func _hide_screen() -> void:
	hide()
	EventBus.request_continue.emit()

func _get_screen_orientation() -> DisplayServer.ScreenOrientation:
	if _is_screen_in_portrait():
		return DisplayServer.ScreenOrientation.SCREEN_PORTRAIT
	else:
		return DisplayServer.ScreenOrientation.SCREEN_LANDSCAPE

func _is_screen_in_portrait() -> bool:
	var screen_size: Vector2
	if OS.has_feature("editor"):
		screen_size = DisplayServer.window_get_size()
	else:
		screen_size = DisplayServer.screen_get_size()
	return (screen_size.x/screen_size.y) < 1

func _on_time_to_rotate_timeout() -> void:
	$PleaseRotateScreen/VBoxContainer/Ignore.show()

func _on_ignore_pressed() -> void:
	_hide_screen()
