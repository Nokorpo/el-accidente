extends Node
## Main communication between scenes. It can also be used to abstract events
## from the game world so anyone can subscribe to them (eg. for achievements).

@warning_ignore("unused_signal") # Used in multiple places in the code
signal change_scene(event_data: ChangeSceneEvent)

class ChangeSceneEvent extends Resource:
	var scene: PackedScene
	func _init(_scene: PackedScene) -> void:
		scene = _scene

@warning_ignore("unused_signal")
signal reload_level()

@warning_ignore("unused_signal")
signal request_pause()
@warning_ignore("unused_signal")
signal request_continue()
