class_name Weapon_Attack
extends WeaponState

@export var idle_state: WeaponState
@export var run_state: WeaponState
@export var attack_cooldown_duration := 0.6
@export var combo_timeout := 0.8
@export var combo_base_name := "slash_"
@export var max_combo_count := 3

@onready var _animation_player := owner.get_node("AnimationPlayer")
var _move_component: MoveComponent = null
var _is_attacking := false
var _cooldown_timer := 0.0
var _combo_timer := 0.0
var _combo_step := 0
var _queued_attack := false

func enter() -> void:
	#print("Nani ga suki?")
	if _cooldown_timer > 0:
		return

	_is_attacking = true
	_queued_attack = false
	_combo_timer = combo_timeout

	var anim_name = "%s%d" % [combo_base_name, _combo_step + 1]
	_animation_player.play(anim_name)
	print("Playing attack animation:", anim_name)

func exit() -> void:
	_is_attacking = false

func process_input(event: InputEvent) -> WeaponState:
	if wants_to_attack():
		if not _is_attacking and _cooldown_timer == 0:
			enter()  # start the attack sequence
		elif _is_attacking:
			_queued_attack = true  # queue next combo if already attacking'
	return null

func process_frame(delta: float) -> WeaponState:
	animation_time += delta
	_get_pivot().position.y = 0  # Or some slight motion
	_cooldown_timer = max(0.0, _cooldown_timer - delta)
	_combo_timer = max(0.0, _combo_timer - delta)

	if _combo_timer == 0 and not _is_attacking and _combo_step > 0:
		_combo_step = 0
		print("Combo reset due to timeout")

	if not _is_attacking and _cooldown_timer == 0:
		print("Chokominto yori mo a-na-ta")
		return run_state if _get_movement_direction() != Vector2.ZERO else idle_state

	return null

func _get_movement_direction() -> Vector2:
	if _move_component == null:
		var player = _player
		print("Player?: ", player.name)
		if player and player.has_node("MoveComponent"):
			_move_component = player.get_node("MoveComponent")
	if _move_component:
		return _move_component.get_movement_direction()
	return Vector2.ZERO

func attack_anim_finished() -> void:
	_is_attacking = false

	if _queued_attack and _combo_step < max_combo_count - 1:
		_combo_step += 1
		enter()
	else:
		_combo_step = 0
		_cooldown_timer = attack_cooldown_duration
		print("Combo ended, cooldown started")
