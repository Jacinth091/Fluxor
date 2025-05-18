class_name Idle_State
extends State

@export
var run_state: State
@export
var dash_state: State
#@export
#var attack_state: State
var move_comp : MoveComponent
func enter() -> void:
	super()
	_get_animation_player().play("Idle");
	move_comp = _get_move_component()
	#_parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	if wants_to_dash():
		return dash_state
	if get_movement_direction() != Vector2.ZERO:
		return run_state
	#if Input.is_action_pressed('attack'):
		#return attack_state;
	return null

func process_frame(delta: float) -> State:


	return null;

func process_physics(delta: float) -> State:

	_parent.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
	_parent.velocity = _parent.velocity.move_toward(Vector2.ZERO, move_comp.move_stats.friction * delta)
	_parent.move_and_slide()
	for i in _parent.get_slide_collision_count():
		var collision = _parent.get_slide_collision(i)
		if collision:
			var normal = collision.get_normal()
			# Remove the component of velocity that's against the wall
			_parent.velocity = _parent.velocity.slide(normal)
	return null
