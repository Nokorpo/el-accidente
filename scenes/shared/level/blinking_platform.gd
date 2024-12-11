extends Node2D

@export var time_visible: float = 1.6
@export var time_to_transition_to_invisible: float = 1
@export var time_invisible: float = 1
@export var time_to_transition_to_visible: float = 0.5

func _ready():
	start_disappearing()

func start_disappearing():
	var timer: SceneTreeTimer = get_tree().create_timer(time_visible)
	await timer.timeout
	
	var shape: CollisionShape2D = $StaticBody2D/CollisionShape2D
	shape.disabled = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), time_to_transition_to_invisible)
	tween.tween_callback(start_appearing)

func start_appearing():
	var timer: SceneTreeTimer = get_tree().create_timer(time_invisible)
	await timer.timeout
	
	var shape: CollisionShape2D = $StaticBody2D/CollisionShape2D
	shape.disabled = false
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, time_to_transition_to_visible)
	tween.tween_callback(start_disappearing)
