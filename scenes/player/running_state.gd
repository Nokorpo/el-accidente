extends StateMachineState
class_name RunningState
## State that lets the player character continue running, without user input.

@export var can_decelerate_while_falling: bool = true

var _original_speed: float

@warning_ignore("shadowed_variable")
func _start(sm: StateMachine, node: Node) -> void:
	super(sm, node)
	_original_speed = node.speed

func _on_enter_state() -> void:
	node.speed = _original_speed
	%AnimatedSprite2D.play("running")

func _process(_delta) -> void:
	if active:
		if Input.is_action_pressed("action"):
			decelerate()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			decelerate()

func _input(event: InputEvent) -> void:
	if active:
		if event is InputEventMouseButton and event.is_pressed():
			decelerate()

func decelerate() -> void:
	if not can_decelerate_while_falling and not node.is_on_floor():
		# player is not on floor, so they are not able to decelerate
		return
	state_machine.change_state(DeceleratingState)
