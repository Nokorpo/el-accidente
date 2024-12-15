extends Area2D

@onready var collision_area: Area2D = $CollisionArea
@onready var sprite: Sprite2D = $Sprite2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.reload_level.connect(reset)
	reset()

func reset() -> void:
	monitoring = true
	collision_area.monitoring = false
	if animated_sprite.animation_finished.is_connected(_fall):
		animated_sprite.animation_finished.disconnect(_fall)
	animated_sprite.stop()
	animation_player.stop()
	animated_sprite.play("default")
	animation_player.play("RESET")
	sprite.hide()
	animated_sprite.show()

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()

func _on_triggered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animated_sprite.animation_finished.connect(_fall)
		animated_sprite.play("trigger")

func _fall() -> void:
	animation_player.play("fall")
