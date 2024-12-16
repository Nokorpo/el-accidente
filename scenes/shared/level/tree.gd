extends AnimatedSprite2D

@onready var crashed_car: AnimatedSprite2D = $CrashedCar
@onready var fire: AnimatedSprite2D = $Fire
@onready var flashazo: TextureRect = $CanvasLayer/Flashazo
@onready var end_screen: TextureRect = $CanvasLayer/EndScreen

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		AudioManager.sfx_car_crash.play()
		
		# show crash animated sprites, hide player
		play("fire")
		body.process_mode =Node.PROCESS_MODE_DISABLED
		body.hide()
		crashed_car.show()
		crashed_car.play()
		fire.show()
		fire.play()
		
		# pause for drama
		var timer = get_tree().create_timer(4)
		await timer.timeout
		
		# show end screen
		flashazo.self_modulate = Color.BLACK
		var tween := flashazo.create_tween()
		tween.tween_property(flashazo, "modulate", Color.WHITE, 2)
		tween.tween_interval(1)
		await tween.finished
		end_screen.show()
		
		# back to menu
		tween = flashazo.create_tween()
		tween.tween_property(flashazo, "modulate", Color.TRANSPARENT, 2)
		tween.tween_interval(6)
		tween.tween_property(flashazo, "modulate", Color.WHITE, 2)
		await tween.finished
		EventBus.change_scene.emit(EventBus.ChangeSceneEvent.new(
			load("res://scenes/menu/main_menu.tscn")
		))


func _flashazo(body):
	if body.is_in_group("player"):
		var tween := flashazo.create_tween()
		tween.tween_property(flashazo, "modulate", Color.WHITE, .2)
		tween.tween_interval(.25)
		tween.tween_property(flashazo, "modulate", Color.TRANSPARENT, .2)
		$AudioStreamPlayer.play()
