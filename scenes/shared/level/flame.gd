extends Area2D

@export var time_on: float = 1
@export var time_off: float = 1
@export var time_for_transition: float = 0.5

static var _timer: Timer

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var _is_active: bool = false
var _is_visible: bool = false

func _ready() -> void:
	if _timer == null:
		_timer = Timer.new()
		get_tree().root.add_child.call_deferred(_timer)
	_timer.timeout.connect(toggle_fire)
	_is_active = false
	_is_visible = false
	_timer.start.call_deferred(time_off)

func toggle_fire() -> void:
	_is_active = not _is_active
	if _is_active:
		sprite.play("turn_on")
		await sprite.animation_finished
		sprite.play("on_loop")
		monitoring = true
		$CollisionShape2D.debug_color = Color(Color.RED, 0.42)
		_timer.start(time_on)
		if _is_visible:
			AudioManager.sfx_flame_thrower.play()
	else:
		monitoring = false
		$CollisionShape2D.debug_color = Color(Color.SKY_BLUE, 0.42)
		sprite.play("turn_off")
		await sprite.animation_finished
		sprite.play("off")
		_timer.start(time_off)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	_is_visible = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_is_visible = false
