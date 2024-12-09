@tool
extends Marker2D
## Target distance for the player's dash. When the dash is over, the player
## character should be where this marker was when the dash was triggered.

func _process(delta: float) -> void:
	if OS.has_feature("editor"):
		queue_redraw()

func _draw() -> void:
	if OS.has_feature("editor"):
		var new_transform: Transform2D = get_global_transform().inverse()
		var parent_position: Vector2 = new_transform * get_parent().global_position
		draw_line(parent_position, Vector2.ZERO, Color.LIGHT_BLUE, 4)
		draw_circle(Vector2.ZERO, 10, Color.LIGHT_BLUE)
		draw_string(ThemeDB.fallback_font, Vector2(-20, -40), "DASH")
		draw_string(ThemeDB.fallback_font, Vector2(-35, -20), "DISTANCE")
