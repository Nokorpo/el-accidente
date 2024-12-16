extends StateMachineState
class_name DashingState
## State for when the user releases the screen and the player character dashes
## forward at high speed.

## How long it takes the dash to finish, in seconds
@export var time_to_complete_dash: float = 0.15
@export var dash_vfx: AnimatedSprite2D

var _target_position: Vector2
var _target_finish_time: float
var _time_entered: float
var _original_position: Vector2
var _original_speed: float

func _on_enter_state() -> void:
	_original_speed = node.speed
	_original_position = node.global_position
	_target_finish_time = time_to_complete_dash
	_target_position = %DashDistance.get_global_position()
	_time_entered = Time.get_ticks_msec()
	node.is_affected_by_gravity = false
	node.speed = 0
	%AnimatedSprite2D.play("dash")
	dash_vfx.play("dash")
	AudioManager.sfx_dash.play()

	if %WillCollideWithWall.is_colliding():
		state_machine.change_state(DashingCutShortState)


func _on_exit_state() -> void:
	node.speed = _original_speed
	node.is_affected_by_gravity = true
	dash_vfx.play("default")

func _process(_delta) -> void:
	if active:
		var elapsed_time: float = (Time.get_ticks_msec() - _time_entered)/1000
		var percent = min(1, elapsed_time/_target_finish_time)
		node.position.x = lerp(_original_position.x, _target_position.x, percent)
		if percent >= 1:
			state_machine.change_state(RunningState)
