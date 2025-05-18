class_name Move_Input_Component extends Node

@export var move_component : MoveComponent
@export var move_stats : MoveStats
var velocity : Vector2
var can_dash : bool
var _input_vector : Vector2


func get_player_move_input() -> void:
	_input_vector = Vector2.ZERO
	_input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	_input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	_input_vector = _input_vector.normalized();
	move_component.input_velocity = _input_vector
	print("Input has pressed")
	pass
	## Apply acceleration or friction
	#if _input_vector.length() > 0:
		#velocity = velocity.move_toward(_input_vector * move_stats.move_speed, move_stats.acceleration)
	#else:
		#velocity = velocity.move_toward(Vector2.ZERO, move_stats.friction)
	## Pass velocity to MoveComponent
	#move_component.input_velocity = velocity

func player_dash()-> void:
	move_component.can_dash = Input.is_action_just_pressed("dodge")
	pass
