@tool
extends Control

const MAX_POINTS: int = 400
var points: PackedVector2Array

@onready var background: ColorRect = $ColorRect
@onready var fps_value: Label = $HBoxContainer/FpsValue

func _ready() -> void:
	if not Engine.is_editor_hint() and not OS.has_feature("editor"):
		process_mode = PROCESS_MODE_DISABLED
		hide()

func _draw() -> void:
	if not Engine.is_editor_hint() and is_node_ready() and points.size() > 2:
		draw_polyline(points, Color.GREEN, 5)

func _process(_delta: float) -> void:
	if not Engine.is_editor_hint() and OS.has_feature("editor"):
		var fps: float = Engine.get_frames_per_second()
		fps_value.text = str(fps)
		var current_size: int = points.size()
		if current_size < MAX_POINTS:
			points.append(Vector2(current_size, background.get_rect().size.y - fps))
		else:
			points = points.slice(1, MAX_POINTS)
			for i in points.size():
				points[i].x -= 1
			points.append(Vector2(MAX_POINTS, background.get_rect().size.y - fps))
		queue_redraw()
