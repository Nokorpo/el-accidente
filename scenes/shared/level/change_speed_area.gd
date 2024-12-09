extends Area2D

@export var player: Player
@export var speed_increment: float


func _on_body_entered(body):
	if body.is_in_group("player"):
		player.speed *= speed_increment
