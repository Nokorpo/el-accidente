extends Control
## Curtain animation used when respawning

func _ready():
	EventBus.reload_level.connect(_play_curtain_animation)

func _play_curtain_animation():
	$AnimationPlayer.play("next_level")
