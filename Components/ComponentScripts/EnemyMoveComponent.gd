class_name EnemyMoveComponent
extends MoveComponent

enum Mode { IDLE, WANDER, FOLLOW }
var current_mode: Mode = Mode.IDLE : set = set_current_mode, get = get_current_mode

@export var wander_interval_min := 1.0
@export var wander_interval_max := 3.0

var _move_direction: Vector2 = Vector2.ZERO
var _wander_timer: float = 0.0

func _ready() -> void:
	_randomize_direction()

func _physics_process(delta: float) -> void:
	if current_mode == Mode.WANDER:
		if _wander_timer <= 0:
			_randomize_direction()
		else:
			_wander_timer -= delta

func get_movement_direction() -> Vector2:
	match current_mode:
		Mode.IDLE:
			return Vector2.ZERO
		Mode.WANDER:
			return _move_direction.normalized()
	return Vector2.ZERO

func want_dodge() -> bool:
	return false

func _randomize_direction() -> void:
	_move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	_wander_timer = randf_range(wander_interval_min, wander_interval_max)
	
	
func set_current_mode(mode : Mode) -> void:
	#if not mode is Mode:
		#current_mode = Mode.IDLE;
	#else:
		#current_mode = mode;
	current_mode = mode;
	pass
	
func get_current_mode() -> Mode:
	return current_mode;
