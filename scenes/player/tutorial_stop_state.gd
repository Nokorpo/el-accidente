extends StateMachineState
class_name TutorialStopState
## Initial state for the player character. We wait for the user to touch the
## screen before making it move.

var _original_speed: float

func _on_enter_state() -> void:
	_original_speed = node.speed
	node.speed = 0
	%AnimatedSprite2D.play("stop")

func _on_exit_state() -> void:
	node.speed = _original_speed

func _process(_delta) -> void:
	if Input.is_action_just_pressed("action"):
		state_machine.change_state(DeceleratingState)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			state_machine.change_state(DeceleratingState)
