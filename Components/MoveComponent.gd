
class_name MoveComponent extends Node


func get_movement_direction() -> Vector2:
	var _input_vector = Vector2.ZERO
	_input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	_input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	_input_vector = _input_vector.normalized();
	return _input_vector

func want_dodge() -> bool:
	return Input.is_action_just_pressed("dodge");
