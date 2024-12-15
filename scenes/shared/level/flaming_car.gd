extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.reload_level.connect(reset)
	reset()

func reset() -> void:
	$AnimationPlayer.play("RESET")
	$CollisionArea.monitoring = true

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()

func _on_triggered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimationPlayer.play("run")
