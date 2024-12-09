extends Polygon2D

func _draw() -> void:
	draw_polyline(self.polygon, Color.BLACK, 30, true)
