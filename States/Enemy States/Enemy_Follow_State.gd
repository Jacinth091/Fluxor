class_name Enemy_Follow_State
extends EnemyBaseState

@export var chase_speed: float = .0
@export var enemy_idle_state: EnemyBaseState
@export var enemy_wander_state: EnemyBaseState

var player: CharacterBody2D = null

func enter() -> void:
	print("BOGGOOOOOOOO")
	player = get_detected_player()
	if player == null:
		print("Warning: player null in state ", self.name)
	else:
		print("Boang Piste yawa")
		_parent._base_animation_player.play("bat_move")

func process_physics(delta: float) -> EnemyBaseState:
	player = get_detected_player()
	var to_player = player.global_position - _parent.global_position
	var _distance := to_player.length()
	var direction := to_player.normalized()

	print("Player distance: ", _distance)

	if _distance > 25:
		_parent.velocity = _parent.velocity.move_toward(direction * move_speed, acceleration * delta)
	else:
		_parent.velocity = _parent.velocity.move_toward(Vector2.ZERO, friction * delta)
	_parent.move_and_slide()
	if direction.x != 0:
		_parent._last_input_direction = direction
		_parent._enemy_sprite.flip_h = direction.x < 0
	return null
