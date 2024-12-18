extends Node2D

@export var camera: Camera2D
@export var offset_quantity: float

var _current_offset: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	camera.offset.y = lerp(camera.offset.y, _current_offset, .01)

func change_offset(body):
	if body.is_in_group("player"):
		_current_offset = offset_quantity

func reset_offset(body):
	if body.is_in_group("player"):
		_current_offset = 0
