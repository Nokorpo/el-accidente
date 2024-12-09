extends StateMachineState
class_name DeceleratingState
## State for when the user is pressing the screen. The player slows down up to
## a minimum speed.

## How long it takes for the character to be completely slowed down, in seconds
@export var time_until_slowed_down: float = 1
## Player speed when completely slowed down
@export var speed_when_lowed_down: float = 7
## How long it takes for the slow down to resolve into a dash, in seconds
@export var time_until_dash: float = .5
var _original_speed: float
var _time_entered: float
var active: bool = false

func _on_enter_state() -> void:
	active = true
	_original_speed = node.speed
	_time_entered = Time.get_ticks_msec()
	%AnimatedSprite2D.play("decelerating")

func _on_exit_state() -> void:
	active = false

func _process(_delta: float) -> void:
	if active:
		var elapsed_time: float = (Time.get_ticks_msec() - _time_entered)/1000
		var percent = min(1, elapsed_time/time_until_slowed_down)
		node.speed = lerp(_original_speed,
			time_until_slowed_down,
			percent)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and not event.is_pressed():
		var elapsed_time: float = (Time.get_ticks_msec() - _time_entered)/1000
		if elapsed_time >= time_until_dash:
			state_machine.change_state(DashingState)
		else:
			state_machine.change_state(RunningState)
