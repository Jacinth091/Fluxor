class_name WeaponIdle
extends State  # Inherits from your weapon-specific base state

@export var attack_state: State
@onready var _weapon_pivot := %WeaponPivot
@export var rotation_speed: float = 15.0
var target_rotation: float = 0.0

func enter() -> void:
	_animation_player.play("idle")  # idle animation for weapon (if exists)

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack"):
		return attack_state
	return null

func process_frame(delta: float) -> State:


	return null

func process_physics(delta: float) -> State:

	return null
	
func _physics_process(delta: float) -> void:
	var mouse_pos = _parent.get_global_mouse_position()
	var dir = mouse_pos - _weapon_pivot.global_position

	# Flip the pivot depending on mouse side
	_weapon_pivot.scale.x = -1 if dir.x < 0 else 1

	# Calculate the target angle to mouse
	target_rotation = dir.angle()

	# If flipped, invert the rotation angle so weapon aims correctly
	if _weapon_pivot.scale.x < 0:
		target_rotation = PI - target_rotation

	# Smoothly rotate the pivot (or sprite) to target angle
	_weapon_pivot
	pass
