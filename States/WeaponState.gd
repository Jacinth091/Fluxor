class_name WeaponState
extends Node

var _player : CharacterBody2D
var _parent: Node2D
var _weapon: Weapon_Sword
var animation_time := 0.0
func _get_animation_player() -> AnimationPlayer:
	return _parent.get_node("AnimationPlayer")
func _get_sprite() -> Sprite2D:
	return _parent.get_node("Sprite2D")
func _get_move_component() -> MoveComponent:
	return _parent.get_node("MoveComponent")
func _get_pivot() -> Marker2D :
	return _parent.get_node("Pivot")
func _get_health_component() -> HealthComponent:
	return _parent.get_node("HealthComponent")
func _get_attack_component() -> AttackComponent:
	return _parent.get_node("AttackComponent")
func _get_hitbox_component() -> HitboxComponent:
	return _parent.get_node("HitboxComponent")
func _get_hurtbox_component() -> HurtboxComponent:
	return _parent.get_node("HurtboxComponent")


func enter() -> void:
	pass
func exit() -> void:
	pass

func process_frame(delta: float) -> WeaponState:
	return null

func process_input(event: InputEvent) -> WeaponState:
	return null
	
# Move Component Helper methods
func get_movement_direction() -> Vector2:
	return  _get_move_component().get_movement_direction()

func reset_pivot_y_pos()->void:
	_get_pivot().position = Vector2.ZERO

func wants_to_dash() -> bool:
	return _get_move_component().wants_to_dash()
# Attack Component Methods
func wants_to_attack() -> bool:
	return _get_attack_component().wants_attack()
