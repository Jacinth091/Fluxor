class_name State
extends Node

@export var animation_name : String;
@export var move_speed := 80;
@export var acceleration : int = 300;
@export var friction : int = 500;


var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
# Hold a reference to the parent so that it can be controlled by the state
var _parent: CharacterBody2D
var _animation_player : AnimationPlayer
var _sprite : Sprite2D
var _move_component : MoveComponent


func enter() -> void:
	_animation_player.play(animation_name)
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func get_movement_dir()-> Vector2:
	return _move_component.get_movement_direction();

func wants_to_dodge() -> bool:
	return _move_component.want_dodge();

	
