extends StateMachineState
class_name TutorialStopState

var _original_speed: float

func _on_enter_state() -> void:
	_original_speed = node.speed
	node.speed = 0

func _on_exit_state() -> void:
	node.speed = _original_speed

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			state_machine.change_state(SlowingDownState)
