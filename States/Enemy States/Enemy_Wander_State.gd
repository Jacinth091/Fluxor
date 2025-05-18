class_name Enemy_Wander_State extends EnemyBaseState

@export var wander_duration: float = 5.0
@export var wander_speed: float = 60.0
@export var enemy_idle_state: EnemyBaseState
@export var enemy_detection_state: EnemyBaseState

var _timer: float = 0.0
var _direction: Vector2 = Vector2.ZERO

func enter() -> void:

	print("Its Wander Time")
	_timer = wander_duration
	_move_component.set_current_mode(EnemyMoveComponent.Mode.WANDER);
	_parent._base_animation_player.play("bat_move")
	

func process_physics(delta: float) -> EnemyBaseState:
	if not _player:
		print("Player is Nulllll")

	_direction = _move_component.get_movement_direction()
	print("Direction: ", _direction)
	if not _direction == Vector2.ZERO:
		_parent.velocity = _parent.velocity.move_toward(_direction * move_speed, acceleration * delta)
	else:
		_parent.velocity = _parent.velocity.move_toward(Vector2.ZERO, friction * delta)
	_parent.move_and_slide()
	
	if get_detected_player() != null:
		print("Bogo")
		return enemy_detection_state
	# Flip sprite based on direction
	if _direction.x != 0:
		_parent._enemy_sprite.flip_h = _direction.x < 0
	_timer -= delta
	if _timer <= 0:
		return enemy_idle_state
	return null
