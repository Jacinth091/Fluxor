
class_name Enemy_Idle_State extends EnemyBaseState

@export var enemy_detection_state: EnemyBaseState
@export var enemy_wander_state: EnemyBaseState
@export var idle_duration: float = 2.0

var _timer: float = 0.0
var _should_follow = false;

func enter() -> void:
	_timer = idle_duration
	_move_component.set_current_mode(EnemyMoveComponent.Mode.IDLE)
	_parent.velocity = Vector2.ZERO
	_animation_player.play("bat_idle")
	_should_follow = false

func process_physics(delta: float) -> EnemyBaseState:
	_parent.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	
	# Smooth stop movement
	_parent.velocity = _parent.velocity.move_toward(Vector2.ZERO, friction * delta)
	_parent.move_and_slide()
	
	# Update follow flag once per frame
	_should_follow = is_player_detected()
	
	if _should_follow:
		print("Switching to Follow State")
		return enemy_detection_state
	
	_timer -= delta
	print("Idle timer: ", _timer)
	if _timer <= 0:
		print("Switching to Wander State")
		return enemy_wander_state
	
	return null
