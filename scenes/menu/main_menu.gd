extends Node
## Main menu manager

@export var game_scene: PackedScene

func _ready() -> void:
	%StartButton.pressed.connect(func(): EventBus.change_scene.emit(
		EventBus.ChangeSceneEvent.new(game_scene)
	))
	UISounds.subscribe_to_ui_sounds(self)
	await Engine.get_main_loop().process_frame
	%StartButton.grab_focus()

func _on_credits_pressed() -> void:
	%Credits.on_open_pressed()
	_set_buttons_focus(false)

func _on_credits_closed() -> void:
	_set_buttons_focus(true)
	%StartButton.grab_focus()

func _set_buttons_focus(value: bool) -> void:
	var focus_mode: Control.FocusMode
	if value:
		focus_mode = Control.FocusMode.FOCUS_ALL
	else:
		focus_mode = Control.FocusMode.FOCUS_NONE
	%OpenCredits.focus_mode = focus_mode
	%Language.focus_mode = focus_mode
	%StartButton.focus_mode = focus_mode
