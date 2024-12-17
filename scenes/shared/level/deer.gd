extends Area2D

@onready var already_ran_away: bool = false
var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.reload_level.connect(reset)
	reset()

func reset() -> void:
	$AnimationPlayer.play("RESET")
	$CollisionArea.monitoring = true
	already_ran_away = false
	if player != null:
		player.reached_maximum_slowdown.disconnect(run_away)

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()

func _on_triggered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		get_tree().create_timer(2).timeout.connect(run_away)
		body.reached_maximum_slowdown.connect(run_away)

func run_away() -> void:
	if not already_ran_away:
		already_ran_away = true
		$AnimationPlayer.play("flee")
		$CollisionArea.monitoring = false
