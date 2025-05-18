class_name WeaponRun
extends WeaponState

@export var idle_state: WeaponState
@export var attack_state: WeaponState
var _move_component: MoveComponent = null
func enter() -> void:
	super()
	pass
	#_get_animation_player().play("run")  # Play the weapon's run animation

func process_input(event: InputEvent) -> WeaponState:
	if wants_to_attack():
		return attack_state
	elif _get_movement_direction() == Vector2.ZERO:
		return idle_state
	return null

func process_frame(delta: float) -> WeaponState:

	animation_time += delta
	var bob_speed := 10.0
	var bob_height := 2.5
	_get_pivot().position.y = sin(animation_time * bob_speed) * bob_height
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
	# Flip weapon to face mouse
	#var mouse_pos = _parent.get_global_mouse_position()
	#var dir = mouse_pos - _parent.global_position
#
	#if dir.x < 0:
		#_sprite.flip_h = true
		#_sprite.position.x = -abs(_sprite.position.x)
	#else:
		#_sprite.flip_h = false
		#_sprite.position.x = abs(_sprite.position.x)

	# Optional: Bobbing effect based on movement (fake inertia or bounce)
	# _sprite.position.y = sin(Time.get_ticks_msec() / 100.0) * 1.5
