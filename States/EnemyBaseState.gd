class_name EnemyBaseState
extends Node

@export var animation_name: String = ""
@export var move_speed: float = 50.0
@export var acceleration: int = 300
@export var friction: int = 500

var _parent: CharacterBody2D
var _animation_player: AnimationPlayer
var _sprite: Sprite2D
var _move_component: EnemyMoveComponent
var _player: CharacterBody2D = null

func setup(parent: CharacterBody2D, animation_player: AnimationPlayer, sprite: Sprite2D, move_component: EnemyMoveComponent) -> void:
	_parent = parent
	_animation_player = animation_player
	_sprite = sprite
	_move_component = move_component

func enter() -> void:
	#if animation_name != "":
	_animation_player.play(animation_name)
	pass

func exit() -> void:
	pass
func process_input(event: InputEvent) -> EnemyBaseState:
	return null

func process_frame(delta: float) -> EnemyBaseState:
	return null

func process_physics(delta: float) -> EnemyBaseState:
	return null

func player_detected(player: CharacterBody2D) -> void:
	#print("Player?: ", player.name)a
	_player = player

func player_lost() -> void:
	_player = null

func is_player_detected() -> bool:
	return _player != null

func get_detected_player() -> CharacterBody2D:
	return _player

func get_movement_dir() -> Vector2:
	return _move_component.get_movement_direction()

func wants_to_dodge() -> bool:
	return _move_component.want_dodge()
