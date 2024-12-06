class_name Player
extends CharacterBody2D

const SPEED_FPS_MULTIPLIER: float = 3600

## Player speed in pixels/second
@export var speed: float = 10.0
var is_affected_by_gravity: bool = true

func _physics_process(delta: float) -> void:
	velocity.x = lerp( velocity.x,  speed * SPEED_FPS_MULTIPLIER * delta, .9)
	if not is_on_floor() and is_affected_by_gravity:
		velocity += get_gravity() * delta

	move_and_slide()
