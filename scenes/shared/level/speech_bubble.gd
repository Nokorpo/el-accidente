extends Area2D

@export var bubble_speech: Label
@export var bubble_sprite: Sprite2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		bubble_speech.show()
		bubble_sprite.show()
		var tween := bubble_sprite.create_tween()
		tween.tween_property(bubble_sprite, "modulate", Color.WHITE, 1.1)
		var tween2 := bubble_sprite.create_tween()
		tween2.tween_property(bubble_speech, "modulate", Color.WHITE, 1.1)
		AudioManager.sfx_character_speech.play()
