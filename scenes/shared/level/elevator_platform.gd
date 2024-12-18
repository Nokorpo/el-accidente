extends Node2D

@export var mov_speed = 100
var is_moving: bool = false

@onready var destination_position = $DetinationPosition.global_position
@onready var start_position = $Platform.global_position

func _ready() -> void:
	EventBus.reload_level.connect(_reset)

func _process(delta: float) -> void:
	_move(delta)

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("player"):
		is_moving = true

func _move(delta: float):
	if is_moving:
		$Platform.global_position = $Platform.global_position.move_toward(destination_position, delta*mov_speed)
	if $Platform.global_position == destination_position:
		is_moving = false

func _reset() -> void:
	is_moving = false
	$Platform.global_position = start_position
