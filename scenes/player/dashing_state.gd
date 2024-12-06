extends StateMachineState
class_name DashingState

func _on_enter_state() -> void:
	node.speed = 30
	$Timer.start()
	node.is_affected_by_gravity = false
	pass # Invulnerabilidad, no gravity...

func _on_exit_state() -> void:
	$Timer.stop()
	node.is_affected_by_gravity = true
	pass # vulnerabilidad, gravity

func _finish_dash() -> void:
	state_machine.change_state(RunningState)
