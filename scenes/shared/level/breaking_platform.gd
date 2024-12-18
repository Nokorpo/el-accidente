extends AnimatedSprite2D

func _ready() -> void:
	EventBus.reload_level.connect(_reset)

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("player"):
		play("breaking")
		AudioManager.sfx_breaking_platform.play()

func _on_animation_finished() -> void:
	hide()
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)

func _reset() -> void:
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	show()
	animation = "default"
