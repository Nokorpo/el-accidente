extends TextureRect

@onready var original_color: Color = material.get_shader_parameter("color")

func _ready() -> void:
	material.set_shader_parameter("color", Color.TRANSPARENT)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			material.set_shader_parameter("color", original_color)
		else:
			material.set_shader_parameter("color", Color.TRANSPARENT)
