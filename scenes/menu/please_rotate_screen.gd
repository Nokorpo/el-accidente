extends PanelContainer

func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	if _is_screen_in_portrait():
		show()
	elif visible:
		hide()

func _is_screen_in_portrait() -> bool:
	var screen_size: Vector2
	if OS.has_feature("editor"):
		screen_size = DisplayServer.window_get_size()
	else:
		screen_size = DisplayServer.screen_get_size()
	return (screen_size.x/screen_size.y) < 1
