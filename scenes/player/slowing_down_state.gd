extends StateMachineState
class_name SlowingDownState

@export var time_until_completely_slowed_down: float = 1
@export var speed_when_completely_slowed_down: float = 6
var _original_speed: float
var _time_entered: float
var active: bool = false

func _on_enter_state() -> void:
	active = true
	_original_speed = node.speed
	_time_entered = Time.get_ticks_msec()

func _on_exit_state() -> void:
	active = false

func _process(_delta: float) -> void:
	if active:
		node.speed = lerp(_original_speed,
			speed_when_completely_slowed_down,
			time_until_completely_slowed_down)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not event.is_pressed():
			state_machine.change_state(DashingState)
