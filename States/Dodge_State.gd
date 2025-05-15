class_name Dodge_State extends State

@export var run_state: State
@export var idle_state: State
#@export var attack_state: State
@export var dash_speed: float = 150.0
@export var dash_duration: float = 0.1
@export var dash_cooldown_duration : float = 5.0

var _dash_direction: Vector2 = Vector2.ZERO
var _dash_timer: float = 0.0
var _cooldown_timer: float = 0.0
var _can_dodge: bool = true;


func enter() -> void:
	super()
	
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
	
	# Set dash direction
	if _parent.velocity.length() > 0:
		_dash_direction = _parent.velocity.normalized()
	else:
		_dash_direction = _parent._last_input_direction.normalized()
	
	_animation_player.play("Hurt")
	
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
		_parent.velocity = _dash_direction * dash_speed
		_parent.move_and_slide()
		return null
	
	var input = get_movement_input()
	return run_state if input != Vector2.ZERO else idle_state

func get_movement_input() -> Vector2:
	return get_movement_dir();
