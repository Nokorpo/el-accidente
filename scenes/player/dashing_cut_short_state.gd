extends DashingState
class_name DashingCutShortState


func _on_enter_state() -> void:
	# no hace falta lanzar la animación porque ya lo hace el DashingState original
	_original_speed = node.speed
	_original_position = node.global_position
	_target_position = %DashDistance.get_global_position()
	_time_entered = Time.get_ticks_msec()
	node.is_affected_by_gravity = false
	node.speed = 0

	var _will_collide: RayCast2D = %WillCollideWithWall
	var would_be_distance: float = _original_position.distance_to(_target_position)
	var dash_speed: float = would_be_distance / time_to_complete_dash
	var actual_distance = _original_position.distance_to(_will_collide.get_collision_point()) - %CollisionShape2D.shape.radius
	_target_finish_time = actual_distance / dash_speed
	if _target_finish_time <= 0:
		# player is already colliding with something
		state_machine.change_state(RunningState)
