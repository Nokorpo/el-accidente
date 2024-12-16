class_name Player
extends CharacterBody2D
## Player character physics controller. It should only handle physics,
## no game logic.

signal requested_stop_for_animation
signal requested_continue

const SPEED_FPS_MULTIPLIER: float = 3600

## Player speed in pixels/second
@export var speed: float = 8
## At which depth the player will respawn
@export var respawn_depth_threshold: float = 2000
## SpriteFrames used when player is running
@export var running_sprite_frames: SpriteFrames
## SpriteFrames used when player is in the car
@export var car_sprite_frames: SpriteFrames

@onready var is_touching_floor_raycast: RayCast2D = $IsTouchingFloor


var is_affected_by_gravity: bool = true
var is_using_car: bool = false

var _checkpoint: Vector2 = Vector2.ZERO
var _camera: Camera2D = null
var _initial_camera_position: Vector2
var _is_already_dying: bool = false

var _current_floor_angle: float = 0

func _ready() -> void:
	if has_node("Camera2D"):
		_camera = get_node("Camera2D")
		_initial_camera_position = _camera.position
	_checkpoint = global_position
	EventBus.reload_level.connect(respawn)
	$AnimatedSprite2D.sprite_frames = running_sprite_frames
	is_using_car = false
	_is_already_dying = false

func _process(_delta: float) -> void:
	$AnimatedSprite2D.rotation = lerp($AnimatedSprite2D.rotation, _current_floor_angle, .1)

func _physics_process(delta: float) -> void:
	velocity.x = lerp( velocity.x,  speed * SPEED_FPS_MULTIPLIER * delta, .9)
	if not is_on_floor() and is_affected_by_gravity:
		velocity += get_gravity() * delta

	move_and_slide()
	if is_touching_floor() and is_affected_by_gravity:
		var normal: Vector2 = get_floor_raycast_normal()
		_current_floor_angle = atan2(normal.y, normal.x) + PI/2

	if global_position.y >= respawn_depth_threshold:
		die()
	
	if Input.is_action_just_pressed("reset"):
		die()

## Raycast to know if we're touching the floor
func is_touching_floor() -> bool:
	return is_touching_floor_raycast.is_colliding()

## Raycast to get the floor normal
func get_floor_raycast_normal() -> Vector2:
	return is_touching_floor_raycast.get_collision_normal()

## Sets the new checkpoint, in global coordinates
func set_checkpoint(new_checkpoint: Vector2) -> void:
	self._checkpoint = new_checkpoint

func die() -> void:
	if not _is_already_dying:
		_is_already_dying = true
		AudioManager.sfx_transition.play()
		EventBus.play_curtain_animation.emit()

func respawn() -> void:
	global_position = _checkpoint
	_camera.position_smoothing_enabled = false
	_camera.global_position = _checkpoint
	_camera.position = _initial_camera_position
	
	await get_tree().process_frame
	_is_already_dying = false
	_camera.position_smoothing_enabled = true
	$StateMachine.change_state(RunningState)

# FIXME no se me ocurre otra manera de hacer estos métodos, pero joden la interfaz del player
# haciendo que tenga muchas responsabilidades T_T
func change_sprite_to_car() -> void:
	is_using_car = true
	AudioManager.sfx_car_engine_start.play()
	$AnimatedSprite2D.sprite_frames = car_sprite_frames
	%CollisionShape2D2.disabled = false
	$DashVFX.position.x -= 150
	%FootDust.position.x += 64
	$FootSparks.position.x -= 64

func stop_for_animation() -> void:
	requested_stop_for_animation.emit()

func animation_finished() -> void:
	requested_continue.emit()

func disable_input() -> void:
	var state_machine: StateMachine = $StateMachine
	state_machine.propagate_call("set_process_input", [false])
	if state_machine.is_current_state(DeceleratingState):
		state_machine.change_state(DashingState)
