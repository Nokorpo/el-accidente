extends Node
## Handles changing scenes and putting up loading screens in between.

@onready var curtain: Curtain = $UI/Curtain

func _ready() -> void:
	EventBus.change_scene.connect(change_scene)
	get_tree().current_scene.reparent.call_deferred($CurrentScene)

func change_scene(event: EventBus.ChangeSceneEvent) -> void:
	curtain.play_animation()
	await curtain.change_scene_now

	for child in $CurrentScene.get_children():
		child.queue_free()
	var instance = event.scene.instantiate()
	$CurrentScene.add_child(instance)

func persist(node: Node) -> void:
	$PersistedObjects.add_child(node)
