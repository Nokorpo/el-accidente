extends Button

@export var game_scene: PackedScene

func _ready() -> void:
	self.button_up.connect(func(): EventBus.change_scene.emit(
		EventBus.ChangeSceneEvent.new(game_scene)
	))
