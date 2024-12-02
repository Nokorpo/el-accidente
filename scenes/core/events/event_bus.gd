extends Node

@warning_ignore("unused_signal") # Used in multiple places in the code
signal change_scene(event_data: ChangeSceneEvent)

class ChangeSceneEvent extends Resource:
	var scene: PackedScene
	func _init(_scene: PackedScene) -> void:
		scene = _scene
