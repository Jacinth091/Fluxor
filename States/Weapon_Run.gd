class_name WeaponRun
extends State

@export var idle_state: State
@export var attack_state: State

func enter() -> void:
	_animation_player.play("run")  # Play the weapon's run animation

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack"):
		return attack_state
	return null

func process_frame(delta: float) -> State:
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

	return null

func process_physics(delta: float) -> State:
	# Optional: if you want trailing or smoothing effect toward a pivot
	return null
