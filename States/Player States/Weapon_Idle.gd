class_name WeaponIdle
extends WeaponState  # Inherits from your weapon-specific base state

@export var attack_state: WeaponState
@export var run_state: WeaponState
@onready var _weapon_pivot := %WeaponPivot
@export var rotation_speed: float = 15.0
var target_rotation: float = 0.0
var _move_component : MoveComponent = null
func enter() -> void:
	#print("Ruby-chan?d")
	#_get_animation_player().play("idle")  # idle animation for weapon (if exists)
	super()
	pass

func process_input(event: InputEvent) -> WeaponState:
	if wants_to_attack():
		#reset_pivot_y_pos()
		#print("Hai!")
		return attack_state
	if _get_movement_direction() != Vector2.ZERO:
		print("Running eyy")
		return run_state;
	return null

func process_frame(delta: float) -> WeaponState:
	animation_time += delta  # Accumulate time
	var bob_speed := 2.0
	var bob_height := 1.5
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
#func _physics_process(delta: float) -> void:
	#var mouse_pos = _parent.get_global_mouse_position()
	#var dir = mouse_pos - _weapon_pivot.global_position
#
	## Flip the pivot depending on mouse side
	#_weapon_pivot.scale.x = -1 if dir.x < 0 else 1
#
	## Calculate the target angle to mouse
	#target_rotation = dir.angle()
#
	## If flipped, invert the rotation angle so weapon aims correctly
	#if _weapon_pivot.scale.x < 0:
		#target_rotation = PI - target_rotation
#
	## Smoothly rotate the pivot (or sprite) to target angle
	#_weapon_pivot
	#pass
