@tool
extends Polygon2D

const EXPANSION = preload("res://scenes/shared/tools/polygon_expander.tscn")

@export var refresh: bool = false:
	set(value):
		if Engine.is_editor_hint() and is_node_ready():
			_delete_old_expansion()
			_add_expansion()
			refresh = false
@export var set_origin_to_1st_point: bool = false:
	set(value):
		if Engine.is_editor_hint() and is_node_ready():
			_recenter_polygon()
			_delete_old_expansion()
			_add_expansion()
			set_origin_to_1st_point = false

func _ready() -> void:
	if Engine.is_editor_hint():
		if not has_node("PolygonExpander"):
			_delete_old_expansion()
			_add_expansion()

func _delete_old_expansion() -> void:
	for child in get_children():
		if child is StaticBody2D:
			print('Delete node %s' % child.name)
			child.free()

func _add_expansion() -> void:
	var edited_scene: Node = get_tree().edited_scene_root
	print('Add polygon expansion to node %s' % name)

	var expansion: Node2D = EXPANSION.instantiate()
	add_child(expansion)
	expansion.owner = edited_scene
	expansion.scene_file_path = ''

	var child: CollisionPolygon2D = expansion.get_child(0, true)
	child.owner = edited_scene
	expansion.set_editable_instance(child, true)
	child.polygon = self.polygon

func _recenter_polygon() -> void:
	var first_point: Vector2 = polygon[0]
	if first_point.is_equal_approx(Vector2.ZERO):
		return

	polygon[0] = Vector2.ZERO
	for i: int in polygon.size():
		if i == 0: continue
		polygon[i] -= first_point
	global_position += first_point
