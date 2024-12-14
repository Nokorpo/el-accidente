extends Area2D

@export var time_on: float = 1
@export var time_off: float = 1
@export var time_for_transition: float = 0.5

static var _timer: Timer

var _is_active: bool = false

func _ready() -> void:
	if _timer == null:
		_timer = Timer.new()
		get_tree().root.add_child.call_deferred(_timer)
	_timer.timeout.connect(toggle_fire)
	_is_active = false
	_timer.start.call_deferred(time_off)

# TODO placeholder until we have the animations.
# We will have to subscribe to the animation to know when it finishes
# before starting the timer. Also we should launch the right loop
# animation depending on if the fire is on or off
func toggle_fire() -> void:
	_is_active = not _is_active
	if _is_active:
		# TODO uncomment when we have animations. Keep here, we want monitoring
		# to be disabled while the animation plays
		#$AnimationPlayer.play("turn_on")
		#await $AnimationPlayer.animation_finished
		#$AnimationPlayer.play("on_loop")
		monitoring = true
		_timer.start(time_on)
	else:
		monitoring = false
		# TODO uncomment when we have animations. Keep here, we want monitoring
		# to be disabled while the animation plays
		#$AnimationPlayer.play("turn_off")
		#await $AnimationPlayer.animation_finished
		#$AnimationPlayer.play("off")
		_timer.start(time_off)

	$Flame.visible = _is_active #TODO remove when we have animations

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
