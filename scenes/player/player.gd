class_name Player
extends CharacterBody2D
## Player character physics controller. It should only handle physics,
## no game logic.

const SPEED_FPS_MULTIPLIER: float = 3600

## Player speed in pixels/second
@export var speed: float = 10.0
var is_affected_by_gravity: bool = true

func _ready():
	get_tree().root.get_viewport().set_canvas_cull_mask_bit(5, false)

func _physics_process(delta: float) -> void:
	velocity.x = lerp( velocity.x,  speed * SPEED_FPS_MULTIPLIER * delta, .9)
	if not is_on_floor() and is_affected_by_gravity:
		velocity += get_gravity() * delta

	move_and_slide()
