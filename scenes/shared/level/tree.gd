extends AnimatedSprite2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		AudioManager.sfx_car_crash.play()
		play("fire")
		body.process_mode =Node.PROCESS_MODE_DISABLED
		body.hide()
