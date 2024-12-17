extends Control

func _ready() -> void:
	set_visible(false)

func _on_close_pressed() -> void:
	AudioManager.sfx_ui_back.play()
	set_visible(false)

func _on_more_pressed() -> void:
	$More.set_visible(true)

func _on_close_more_pressed() -> void:
	AudioManager.sfx_ui_back.play()
	$More.set_visible(false)
