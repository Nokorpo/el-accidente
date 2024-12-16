extends StateMachineState
class_name DeceleratingState
## State for when the user is pressing the screen. The player slows down up to
## a minimum speed.

## How long it takes for the character to be completely slowed down, in seconds
@export var time_until_slowed_down: float = 0.9
## Player speed when completely slowed down
@export var speed_when_lowed_down: float = 11
## How long it takes for the slow down to resolve into a dash, in seconds
@export var time_until_dash: float = .3
@export var _vfx: AnimatedSprite2D
var _original_speed: float
var _time_entered: float

func _on_enter_state() -> void:
	_original_speed = node.speed
	_time_entered = Time.get_ticks_msec()
	%AnimatedSprite2D.play("decelerating")
	if node.is_using_car:
		AudioManager.sfx_car_decelerate.play()
	else:
		AudioManager.sfx_decelerate.play()
	await %AnimatedSprite2D.animation_finished
	if active:
		%AnimatedSprite2D.play("decelerating_glide")

func _on_exit_state() -> void:
	_vfx.play("default")
	AudioManager.sfx_decelerate.play()

func _process(_delta: float) -> void:
	if active:
		if _dash_ready() and _vfx.get_animation() != "running":
			_vfx.play("running")
		
		var elapsed_time: float = (Time.get_ticks_msec() - _time_entered)/1000
		var percent = min(1, elapsed_time/time_until_slowed_down)
		node.speed = lerp(_original_speed,
			time_until_slowed_down,
			percent)

		if Input.is_action_just_released("action"):
			resolve()

func _input(event: InputEvent) -> void:
	if active:
		if event is InputEventMouseButton and not event.is_pressed():
			resolve()

func resolve() -> void:
	if _dash_ready():
		state_machine.change_state(DashingState)
	else:
		state_machine.change_state(RunningState)
	AudioManager.sfx_decelerate.stop()

func _dash_ready() -> bool:
	var elapsed_time: float = (Time.get_ticks_msec() - _time_entered) / 1000.0
	return elapsed_time >= time_until_dash
