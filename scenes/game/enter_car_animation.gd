extends Area2D

@onready var car_sprite: Sprite2D = $CarSprite

var _player: Player
var _original_speed: float
var _already_fired: bool = false

func _ready() -> void:
	EventBus.reload_level.connect(_reset)

func _process(_delta: float) -> void:
	if _player != null and not _already_fired:
		if _player.global_position.x >= car_sprite.global_position.x:
			_player.global_position.x = car_sprite.global_position.x
			_already_fired = true
			_player.stop_for_animation()
			$TimeStandingBesidesCar.start()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_player = body
		_original_speed = _player.speed

func _on_time_standing_besides_car_timeout() -> void:
	_player.change_sprite_to_car()
	car_sprite.visible = false
	#_player.speed = _original_speed
	_player.animation_finished()

func _reset() -> void:
	_player = null
	_already_fired = false
	car_sprite.visible = true
