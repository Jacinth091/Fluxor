class_name Idle_State
extends State

@export
var run_state: State
@export
var dash_state: State
#@export
#var attack_state: State

func enter() -> void:
	super()
	#_parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	if wants_to_dodge():
		return dash_state
	if get_movement_dir() != Vector2.ZERO:
		return run_state
	#if Input.is_action_pressed('attack'):
		#return attack_state;
	return null

func process_frame(delta: float) -> State:
	_animation_player.play("Idle");

	return null;

func process_physics(delta: float) -> State:
	_parent.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
	_parent.velocity = _parent.velocity.move_toward(Vector2.ZERO, friction * delta)
	#print("Idle: ", _parent.velocity)
	
		# Mouse facing in idle state
	var mouse_pos = _parent.get_global_mouse_position()
	var viewport = _parent.get_viewport()
	
	if viewport.get_visible_rect().has_point(viewport.get_mouse_position()):
		_sprite.flip_h = mouse_pos.x < _parent.global_position.x
	else:
		# Optional: Face last movement direction when mouse leaves
		_sprite.flip_h = _parent._last_input_direction.x < 0 if _parent._last_input_direction.x != 0 else _sprite.flip_h
	_parent.move_and_slide()
	return null
