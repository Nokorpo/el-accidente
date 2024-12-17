extends Control

@export var pause_image: Texture
@export var continue_image: Texture

@onready var pause_counter: int = 0
@onready var button: TextureButton = $Button
@onready var background: Panel = $Panel

func _ready() -> void:
	EventBus.request_pause.connect(pause_requested)
	EventBus.request_continue.connect(continue_requested)
	set_button_texture_to_pause()
	background.hide()

func pause_requested():
	pause_counter += 1
	if pause_counter > 0 and not get_tree().paused:
		get_tree().paused = true
		set_button_texture_to_continue()
		background.show()

func continue_requested():
	pause_counter -= 1
	if pause_counter <= 0:
		pause_counter = 0
		get_tree().paused = false
		set_button_texture_to_pause()
		background.hide()

func set_button_texture_to_pause() -> void:
	button.texture_normal = pause_image
	button.texture_pressed = pause_image
	button.texture_hover = pause_image
	button.texture_disabled = pause_image
	button.texture_focused = pause_image

func set_button_texture_to_continue() -> void:
	button.texture_normal = continue_image
	button.texture_pressed = continue_image
	button.texture_hover = continue_image
	button.texture_disabled = continue_image
	button.texture_focused = continue_image

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		EventBus.request_pause.emit()
		AudioManager.sfx_ui_confirm.play()
	else:
		EventBus.request_continue.emit()
		AudioManager.sfx_ui_back.play()
		
