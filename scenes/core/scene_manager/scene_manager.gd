extends Node

@onready var curtain: Curtain = $UI/Curtain
@onready var please_rotate_panel: PanelContainer = $PleaseRotateScreen
const FULLSCREEN = DisplayServer.WINDOW_MODE_FULLSCREEN
const LANDSCAPE = DisplayServer.SCREEN_LANDSCAPE

func _ready() -> void:
	EventBus.change_scene.connect(change_scene)

## Force set fullscreen on click
func _input(event: InputEvent) -> void:
	print(OS.get_name())
	if OS.get_name() == "Web" and event is InputEventMouse and event.is_pressed():
		if DisplayServer.window_get_mode() != FULLSCREEN:
			DisplayServer.window_set_mode(FULLSCREEN)
		#print("screens: %d" % DisplayServer.get_screen_count())
		#var screen: int = DisplayServer.window_get_current_screen()
		#print("current: %d" % screen)
		#DisplayServer.screen_set_orientation(LANDSCAPE, screen)
		#DisplayServer.screen_set_keep_on(true)

func _is_screen_in_portrait() -> bool:
	var size: Vector2 = DisplayServer.screen_get_size()
	#DisplayServer.screen_get_orientation() != LANDSCAPE
	return (size.x/size.y) < 1

func _process(delta: float) -> void:
	#var orient = DisplayServer.screen_get_orientation()
	#var current= DisplayServer.window_get_current_screen()
	#var count = DisplayServer.get_screen_count()
	#print("orient: %d, current: %d, count: %d" % [orient, current, count])
	if _is_screen_in_portrait():
		please_rotate_panel.show()
	elif please_rotate_panel.visible:
		please_rotate_panel.hide()

func change_scene(event: EventBus.ChangeSceneEvent) -> void:
	curtain.play_animation()
	await curtain.change_scene_now

	for child in $CurrentScene.get_children():
		child.queue_free()
	var instance = event.scene.instantiate()
	$CurrentScene.add_child(instance)

func persist(node: Node) -> void:
	$PersistedObjects.add_child(node)
