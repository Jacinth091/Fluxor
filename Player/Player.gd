class_name Player extends CharacterBody2D
const SPEED : float = 1.7
const MAX_SPEED : int = 75;
const ACCELERATION : int = 400;
const FRICTION : int = 400;

@onready var _animationPlayer: AnimationPlayer = %AnimationPlayer
@onready var _animationTree : AnimationTree = %AnimationTree
@onready var _animationState = _animationTree.get("parameters/playback")
@onready var _idleBlendPos : String = "parameters/Idle/blend_position";
@onready var _runBlendPos : String = "parameters/Run/blend_position";



func _physics_process(delta: float) -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
	var _input_vector = Vector2.ZERO
	_input_vector.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	_input_vector.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	_input_vector = _input_vector.normalized();
	if _input_vector != Vector2.ZERO:
		_animationTree.set(_idleBlendPos, _input_vector);
		_animationTree.set(_runBlendPos, _input_vector);
		_animationState.travel("Run");
		velocity = velocity.move_toward(_input_vector * MAX_SPEED, ACCELERATION * delta)
		#velocity += _input_vector * ACCELERATION  * delta ;
		#velocity = velocity.limit_length(MAX_SPEED);
	else:
		_animationState.travel("Idle");
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	#print(velocity);
	#print("Player global position:", global_position)

	move_and_slide();
	
func _playAnimation(_input_vector: Vector2) -> void:
	if _input_vector.x >= 1:
		_animationPlayer.play("RunRight")
	elif _input_vector.x <= -1:
		_animationPlayer.play("RunLeft")
	elif _input_vector.y <= -1:
		_animationPlayer.play("RunUp")
	elif _input_vector.y >= 1:
		_animationPlayer.play("RunDown")
	pass
