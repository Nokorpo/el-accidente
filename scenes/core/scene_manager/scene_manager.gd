extends Node

@onready var curtain: Curtain = $UI/Curtain
const FULLSCREEN = DisplayServer.WINDOW_MODE_FULLSCREEN

func _ready() -> void:
	EventBus.change_scene.connect(change_scene)
	get_tree().current_scene.reparent.call_deferred($CurrentScene)

## Force set fullscreen on click
func _input(event: InputEvent) -> void:
	if OS.get_name() == "Web" and event is InputEventMouse and event.is_pressed():
		if DisplayServer.window_get_mode() != FULLSCREEN:
			DisplayServer.window_set_mode(FULLSCREEN)

func change_scene(event: EventBus.ChangeSceneEvent) -> void:
	curtain.play_animation()
	await curtain.change_scene_now

	for child in $CurrentScene.get_children():
		child.queue_free()
	var instance = event.scene.instantiate()
	$CurrentScene.add_child(instance)

func persist(node: Node) -> void:
	$PersistedObjects.add_child(node)
