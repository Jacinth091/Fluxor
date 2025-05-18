class_name Dodge_State extends State

@export var run_state: State
@export var idle_state: State
#@export var attack_state: State
@export var dash_speed: float = 200.0
@export var dash_duration: float = 0.1
@export var dash_cooldown_duration : float = 5.0
var _dash_direction: Vector2 = Vector2.ZERO
var _dash_timer: float = 0.0
var _cooldown_timer: float = 0.0
var _can_dodge: bool = true;

var move_comp : MoveComponent

func enter() -> void:
	super()
	move_comp = _get_move_component()
	# Always update cooldown timer first
	if _cooldown_timer > 0:
		_cooldown_timer -= get_physics_process_delta_time()
	
	# Check if we can dodge
	if _cooldown_timer > 0:
		print("Dash On Cooldown")
		_can_dodge = false
		return
	
	# Execute dodge
	_can_dodge = true
	_dash_timer = dash_duration
	_cooldown_timer = dash_cooldown_duration
	dash_in_direction()
	_get_animation_player().play("Hurt")
	
func process_input(event: InputEvent) -> State:
	#if Input.is_action_just_pressed("attack"):
		#return attack_state;
	return null

func _physics_process(delta: float) -> void:
	if _cooldown_timer > 0:
		_cooldown_timer -= delta
	#print(_cooldown_timer)dd
		
func process_physics(delta: float) -> State:
	if not _can_dodge:
		var input = get_movement_input()
		return run_state if input != Vector2.ZERO else idle_state
	
	if _dash_timer > 0:
		_dash_timer -= delta
		dash_in_direction()
		_parent.velocity = _dash_direction * dash_speed
		_parent.velocity = _parent.velocity.move_toward(
			Vector2.ZERO,
			move_comp.move_stats.friction * delta * 2.0  # Faster stop
		)
		_parent.move_and_slide()
		for i in _parent.get_slide_collision_count():
			var collision = _parent.get_slide_collision(i)
			if collision:
				var normal = collision.get_normal()
				_parent.velocity = _parent.velocity.slide(normal)
		return null
	
	var input = get_movement_input()
	return run_state if input != Vector2.ZERO else idle_state

func get_movement_input() -> Vector2:
	return get_movement_direction();

func dash_in_direction()-> void:
	var mouse_dir := (_parent.get_global_mouse_position() - _parent.global_position).normalized()
	var move_dir := get_movement_direction()
	# Blend directions (60% mouse, 40% movement)
	_dash_direction = (mouse_dir * 0.6 + move_dir * 0.4).normalized()
