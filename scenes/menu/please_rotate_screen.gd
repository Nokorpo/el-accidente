extends PanelContainer

func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	var is_in_portrait: bool = _is_screen_in_portrait()
	if is_in_portrait and not visible:
		EventBus.request_pause.emit()
		show()
	elif not is_in_portrait and visible:
		EventBus.request_continue.emit()
		hide()

func _is_screen_in_portrait() -> bool:
	var screen_size: Vector2
	if OS.has_feature("editor"):
		screen_size = DisplayServer.window_get_size()
	else:
		screen_size = DisplayServer.screen_get_size()
	return (screen_size.x/screen_size.y) < 1
