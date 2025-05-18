class_name WeaponAttack
extends State

@export var idle_state: State
@export var run_state: State
@export var attack_cooldown_duration := 0.6  # Change as needed

@onready var _weapon_pivot := %WeaponPivot
@onready var _weapon := %Weapon
#s@onready var _animation_player := %AnimationPlayer

var _combo_count := 0
var _can_combo := false
var _queued_attack := false
var _is_attack_finished := false
var _cooldown_timer := 0.0

func enter() -> void:
	if _cooldown_timer > 0 and not _queued_attack:
		print("Attack on cooldown")
		return

	# Increment combo count
	_combo_count = (_combo_count % 2) + 1
	var anim_name = "swing_right_%d" % _combo_count
	_animation_player.play(anim_name)

	_is_attack_finished = false
	_can_combo = false
	_cooldown_timer = attack_cooldown_duration
func exit() -> void:
	if not _queued_attack:
		_combo_count = 0

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		if _can_combo:
			_can_combo = false
			return self
		elif _cooldown_timer > 0:
			# Ignore input until combo window opens
			# OR queue if combo is already allowed
			_queued_attack = true
	return null

func process_frame(delta: float) -> State:
	if _cooldown_timer > 0:
		_cooldown_timer = max(0, _cooldown_timer - delta)
	
	if _is_attack_finished:
		if _queued_attack and _cooldown_timer <= 0:
			_queued_attack = false
			return self
		
		return run_state if get_movement_dir() != Vector2.ZERO else idle_state
	
	return null

func process_physics(delta: float) -> State:
	return null

func attack_anim_finished() -> void:
	_is_attack_finished = true

func enable_combo() -> void:
	print("Combo window opened")
	_can_combo = true
	if _queued_attack and _cooldown_timer <= 0:
		print("Executing queued combo")
		_queued_attack = false
		_can_combo = false
		call_deferred("_execute_queued_attack")

func disable_combo() -> void:
	_can_combo = false

func _execute_queued_attack():
	get_parent().change_state(self)
