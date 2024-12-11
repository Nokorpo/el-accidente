extends TextureRect

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			material.set_shader_parameter("color", Color.WHITE)
		else:
			material.set_shader_parameter("color", Color.TRANSPARENT)
