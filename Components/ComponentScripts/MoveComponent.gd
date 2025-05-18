
class_name MoveComponent extends Node


##@export var actor : Node2D
##@export var velocity : Vector2
#@export var move_speed := 100
#@export var acceleration: int = 300
#@export var friction: int = 500

@export var move_stats : MoveStats
func get_movement_direction() -> Vector2:
	var _input_velocity = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).normalized();
	return _input_velocity

func wants_to_dash()-> bool:
	return Input.is_action_just_pressed("dodge");
