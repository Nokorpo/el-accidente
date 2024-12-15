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
		AudioManager.sfx_flaming_car.play()
		$AnimationPlayer.play("run")
		await get_tree().create_timer(3.2).timeout
		AudioManager.sfx_combust.play()
