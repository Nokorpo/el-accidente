extends StateMachineState
class_name RunningState
## State that lets the player character continue running, without user input.

var _original_speed: float

func _start(sm: StateMachine, node: Node) -> void:
	super(sm, node)
	_original_speed = node.speed

func _on_enter_state() -> void:
	node.speed = _original_speed

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			state_machine.change_state(SlowingDownState)
