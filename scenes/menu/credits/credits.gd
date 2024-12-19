extends CanvasItem

signal closed

func _ready() -> void:
	set_visible(false)

func on_open_pressed() -> void:
	%Credits.set_visible(true)
	%Close.grab_focus()

func _on_close_pressed() -> void:
	AudioManager.sfx_ui_back.play()
	set_visible(false)
	closed.emit()

func _on_more_pressed() -> void:
	%More.set_visible(true)
	%CloseMore.grab_focus()

func _on_close_more_pressed() -> void:
	AudioManager.sfx_ui_back.play()
	$More.set_visible(false)
	%Close.grab_focus()
