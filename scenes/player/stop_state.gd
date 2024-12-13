extends StateMachineState
class_name StopState
## Initial state for the player character. We wait for the user to touch the
## screen before making it move.

var _original_speed: float

func _on_enter_state() -> void:
	_original_speed = node.speed
	node.speed = 0
	node.is_affected_by_gravity = false
	node.set_physics_process(false)
	%AnimatedSprite2D.animation = "stop"

func _on_exit_state() -> void:
	node.speed = _original_speed
	node.set_physics_process(true)
	node.is_affected_by_gravity = true

## Method to be called from outside StopState. Changes state to StopState.
## Used for the animation where Berta enters the car.
func force_enter_stop_state() -> void:
	state_machine.change_state(StopState)

## Changes state to RunningState.
## Used for the animation where Berta enters the car.
func start_running() -> void:
	state_machine.change_state(RunningState)
