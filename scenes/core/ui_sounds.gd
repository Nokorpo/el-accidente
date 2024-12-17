extends Node
## Adds sounds to the game menus

var audio_player: AudioStreamPlayer

func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.bus = &"SFX"

func subscribe_to_ui_sounds(this_node: Node) -> void:
	for child: Node in _get_all_children(this_node):
		if child is Button:
			if child.is_in_group("ui_back"):
				child.pressed.connect(play_back_sound)
			else:
				child.pressed.connect(play_accept_sound)

func play_accept_sound() -> void:
	AudioManager.sfx_ui_confirm.play()

func play_back_sound() -> void:
	AudioManager.sfx_ui_back.play()

func _play_sound(this_stream: AudioStream) -> void:
	audio_player.stream = this_stream
	audio_player.play()

func _get_all_children(in_node: Node) -> Array:
	var waiting := in_node.get_children()
	var node_list := []
	while not waiting.is_empty():
		var node := waiting.pop_back() as Node
		node_list.append(node)
		waiting.append_array(node.get_children())
	return node_list
