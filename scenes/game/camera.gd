extends Camera2D
## Follows the player character

@export var player: Player

#func _process(_delta: float) -> void:
	#self.global_position = lerp(self.global_position, player.global_position, .9)
