extends AnimatedSprite2D

@onready var player: Player = get_parent()
var _last_position: Vector2

func _ready() -> void:
	_last_position = player.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = lerp(_last_position, player.global_position, .2)
	_last_position = global_position
	rotation = lerp(rotation, player._current_floor_angle, .1)
