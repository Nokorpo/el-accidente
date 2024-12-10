class_name Player
extends CharacterBody2D
## Player character physics controller. It should only handle physics,
## no game logic.

const SPEED_FPS_MULTIPLIER: float = 3600

## Player speed in pixels/second
@export var speed: float = 10.0
## At which depth the player will respawn
@export var respawn_depth_threshold: float = 2000

var is_affected_by_gravity: bool = true

var _checkpoint: Vector2 = Vector2.ZERO

func _ready() -> void:
	_checkpoint = global_position

func _physics_process(delta: float) -> void:
	velocity.x = lerp( velocity.x,  speed * SPEED_FPS_MULTIPLIER * delta, .9)
	if not is_on_floor() and is_affected_by_gravity:
		velocity += get_gravity() * delta

	move_and_slide()

	if global_position.y >= respawn_depth_threshold:
		respawn()

	if Input.is_action_just_pressed("reset"):
		respawn()

func respawn() -> void:
	global_position = _checkpoint
