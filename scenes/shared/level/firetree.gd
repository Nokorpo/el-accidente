extends AnimatedSprite2D
## Tree that appears at the end of the game

@onready var crashed_car: AnimatedSprite2D = $CrashedCar
@onready var fire: AnimatedSprite2D = $Fire
@onready var flashazo: TextureRect = $CanvasLayer/Flashazo
@onready var end_screen: TextureRect = $CanvasLayer/EndScreen

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("player"):
		AudioManager.sfx_car_crash.play()
		
		# show crash animated sprites, hide player
		play("fire")
		body.process_mode = Node.PROCESS_MODE_DISABLED
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
		var the_end := end_screen.get_node_or_null("TheEnd")
		if the_end != null:
			var new_texture := load("res://assets/sprites/ui/end_screen_title_%s.png" % TranslationServer.get_locale())
			if new_texture != null:
				the_end.texture = new_texture
		
		# back to menu
		tween = flashazo.create_tween()
		tween.tween_property(flashazo, "modulate", Color.TRANSPARENT, 2)
		tween.tween_interval(6)
		tween.tween_property(flashazo, "modulate", Color.WHITE, 2)
		await tween.finished
		EventBus.change_scene.emit(EventBus.ChangeSceneEvent.new(
			load("res://scenes/menu/main_menu.tscn")
		))

func _flashazo(body: Node2D):
	if body.is_in_group("player"):
		var tween := flashazo.create_tween()
		tween.tween_property(flashazo, "modulate", Color.WHITE, .2)
		tween.tween_interval(.25)
		tween.tween_property(flashazo, "modulate", Color.TRANSPARENT, .2)
		$AudioStreamPlayer.play()
