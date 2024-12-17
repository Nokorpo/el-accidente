extends Control
## Curtain animation used when respawning

@onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var _timer: Timer = $Timer

func _ready():
	EventBus.play_curtain_animation.connect(_play_curtain_animation)

func _play_curtain_animation():
	# FIXME no descomentar, pq entonces si mueres 2 veces rapido el player deja de poder morir
	#if _animated_sprite_2d.is_playing():
	#	return
	
	var animation_duration := _animated_sprite_2d.sprite_frames.get_frame_count("next_level") \
		/ _animated_sprite_2d.sprite_frames.get_animation_speed("next_level")
	_animated_sprite_2d.play("next_level")
	
	_timer.start(animation_duration / 2.0)
	await _timer.timeout
	
	EventBus.emit_signal("reload_level")
