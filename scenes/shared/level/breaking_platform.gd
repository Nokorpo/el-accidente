extends Sprite2D

func _ready() -> void:
	EventBus.reload_level.connect(reset)

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("player"):
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)

func reset() -> void:
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
