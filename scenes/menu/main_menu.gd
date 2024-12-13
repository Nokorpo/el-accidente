extends Node
## Main menu manager

@export var game_scene: PackedScene

func _ready() -> void:
	%StartButton.pressed.connect(func(): EventBus.change_scene.emit(
		EventBus.ChangeSceneEvent.new(game_scene)
	))

func _on_credits_pressed() -> void:
	%Credits.set_visible(true)
