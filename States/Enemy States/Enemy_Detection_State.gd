class_name Enemy_Detection_State
extends EnemyBaseState

@export var enemy_follow_state: EnemyBaseState
@export var enemy_wander_state: EnemyBaseState
@export var detection_duration: float = 0.3
@export var player_leave_duration: float =0.3;

var _timer: float = 0.0
var _player_timer : float = 0.0

func enter() -> void:
	var player = get_detected_player()
	if player == null:
		print("Warning: player null in state ", self.name)
	_timer = detection_duration
	_player_timer = player_leave_duration
	_move_component.set_current_mode(EnemyMoveComponent.Mode.IDLE) # or a custom DETECTION mode if you want
	_parent.velocity = Vector2.ZERO
	_animation_player.play("bat_idle")
	print("Detecting player...")

func process_physics(delta: float) -> EnemyBaseState:
	_parent.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	
	# Smooth stop movement while detecting
	_parent.velocity = _parent.velocity.move_toward(Vector2.ZERO, friction * delta)
	_parent.move_and_slide()
	
	# Check if player still detected
	if get_detected_player() == null:
		_player_timer -= delta
		print("Player Leave Timer: ", _player_timer)
		if _player_timer <= 0:
			#return enemy_wander_state
			return enemy_follow_state
			
	#else:
		#return enemy_follow_state
		#_timer -= delta
		#if _timer <= 0:
			#print("Player detected, switching to Follow")
			## Pass the player reference to follow state
			##enemy_follow_state.player_detected(get_detected_player())
			#return enemy_follow_state
	# Countdown detection timer

	
	return null
