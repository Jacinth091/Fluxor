class_name Run_State extends State

@export
var idle_state: State
#@export
#var attack_state: State
@export
var dash_state: State

var _last_mouse_position: Vector2 = Vector2.ZERO
var move_comp : MoveComponent
func enter():
	super();
	move_comp = _get_move_component()
func process_input(event: InputEvent) -> State:
	if wants_to_dash():
		return dash_state
	return null

func process_physics(delta: float) -> State:
	_parent.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	var input_vector = get_movement_direction()

	# Only play animation if moving
	if input_vector != Vector2.ZERO:
		_get_animation_player().play("Run")
		# Desired velocity from input
		var target_velocity = input_vector * move_comp.move_stats.move_speed
		# Use move_and_slide to detect wall collision
		_parent.velocity = _parent.velocity.move_toward(target_velocity, move_comp.move_stats.acceleration * delta)
		_parent.move_and_slide()
		# Check for wall collision and cancel movement in blocked direction
		for i in _parent.get_slide_collision_count():
			var collision = _parent.get_slide_collision(i)
			if collision:
				var normal = collision.get_normal()
				# Remove the component of velocity that's against the wall
				_parent.velocity = _parent.velocity.slide(normal)

	else:
		# If no input, apply friction
		_parent.velocity = _parent.velocity.move_toward(Vector2.ZERO, move_comp.move_stats.friction * delta)
		_parent.move_and_slide()
		return idle_state

	return null
	#_parent.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
	#var _input_vector = get_movement_direction();
	#if _input_vector != Vector2.ZERO :
		##_parent._last_input_direction = _input_vector;
		#_get_animation_player().play("Run")
		#_parent.velocity = _parent.velocity.move_toward(_input_vector * move_comp.move_stats.move_speed, move_comp.move_stats.acceleration)
	#else:
		#return idle_state
	#var collision = _parent.move_and_collide(_parent.velocity * delta)
	#if collision:
		#print("Collided with: ", collision.get_collider())

	
	return null
