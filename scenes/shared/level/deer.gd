extends Area2D
## Deer obstacle

var _already_ran_away := false
var _player: Player

func _ready() -> void:
	EventBus.reload_level.connect(_reset)
	_reset()

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()

func _on_triggered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_player = body
		get_tree().create_timer(2.0).timeout.connect(_run_away)
		body.reached_maximum_slowdown.connect(_run_away)

func _reset() -> void:
	$AnimationPlayer.play("RESET")
	$CollisionArea.monitoring = true
	_already_ran_away = false
	if _player != null:
		_player.reached_maximum_slowdown.disconnect(_run_away)

func _run_away() -> void:
	if not _already_ran_away:
		_already_ran_away = true
		$AnimationPlayer.play("flee")
		$CollisionArea.monitoring = false
