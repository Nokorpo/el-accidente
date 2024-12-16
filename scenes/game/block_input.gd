extends Node

var player: Player

func _ready() -> void:
	player = get_tree().root.find_child("Player", true, false)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.disable_input()
