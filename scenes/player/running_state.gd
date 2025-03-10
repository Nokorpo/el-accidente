extends StateMachineState
class_name RunningState
## State that lets the player character continue running, without user input.

@export var can_decelerate_while_falling: bool = true
@export var _player: Player

var _original_speed: float

@warning_ignore("shadowed_variable")
func _start(sm: StateMachine, new_node: Node) -> void:
	super(sm, new_node)
	_original_speed = new_node.speed

func _on_enter_state() -> void:
	node.speed = _original_speed
	%AnimatedSprite2D.play("running")

func _process(_delta) -> void:
	if active and is_processing_input():
		if Input.is_action_pressed("action"):
			decelerate()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			decelerate()
		
		if %AnimatedSprite2D.sprite_frames.has_animation("falling"):
			if _player.is_touching_floor():
				%AnimatedSprite2D.play("running")
			else:
				%AnimatedSprite2D.play("falling")

func _input(event: InputEvent) -> void:
	if active and is_processing_input():
		if event is InputEventMouseButton and event.is_pressed():
			decelerate()

func decelerate() -> void:
	if not can_decelerate_while_falling and not node.is_on_floor():
		# player is not on floor, so they are not able to decelerate
		return
	state_machine.change_state(DeceleratingState)
