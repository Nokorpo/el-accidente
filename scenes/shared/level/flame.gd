extends Area2D

@export var time_on: float = 1
@export var time_off: float = 1
@export var time_for_transition: float = 0.5

static var _timer: Timer

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var _is_active: bool = false

func _ready() -> void:
	if _timer == null:
		_timer = Timer.new()
		get_tree().root.add_child.call_deferred(_timer)
	_timer.timeout.connect(toggle_fire)
	_is_active = false
	_timer.start.call_deferred(time_off)

func toggle_fire() -> void:
	_is_active = not _is_active
	if _is_active:
		sprite.play("turn_on")
		await sprite.animation_finished
		sprite.play("on_loop")
		monitoring = true
		_timer.start(time_on)
		AudioManager.sfx_flame_thrower.play()
	else:
		monitoring = false
		sprite.play("turn_off")
		await sprite.animation_finished
		sprite.play("off")
		_timer.start(time_off)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
