class_name Run_State extends State

@export
var idle_state: State
#@export
#var attack_state: State
@export
var dash_state: State

var _last_mouse_position: Vector2 = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	if wants_to_dodge():
		return dash_state
	#if Input.is_action_pressed('attack'):
		#return attack_state;
	return null

func process_physics(delta: float) -> State:
	_parent.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;

	var _input_vector = get_movement_dir();
	if _input_vector != Vector2.ZERO :
		_parent._last_input_direction = _input_vector;
		_animation_player.play("Run");
		_parent.velocity = _parent.velocity.move_toward(_input_vector * move_speed, acceleration * delta)
		_sprite.flip_h = _input_vector.x < 0
	else:
		return idle_state
	if _parent.velocity.x > 0:
		_sprite.flip_h = false
	else:
		_sprite.flip_h = true
	## Mouse facing logic (works even when mouse leaves window)
	#var mouse_pos = _parent.get_global_mouse_position()
	#var viewport = _parent.get_viewport()
	#
	## Check if mouse is inside viewport
	#if viewport.get_visible_rect().has_point(viewport.get_mouse_position()):
		#_sprite.flip_h = mouse_pos.x < _parent.global_position.x
	#else:
		## When mouse leaves window, maintain last flip state
		#pass

	_parent.move_and_slide();

	
	return null
