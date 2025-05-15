class_name OldPlayer extends CharacterBody2D

@onready var _animationPlayer: AnimationPlayer = %AnimationPlayer
@onready var _animationTree : AnimationTree = %AnimationTree
@onready var _animationState = _animationTree.get("parameters/playback")
@onready var _idle_blend_pos : String = "parameters/Idle/blend_position";
@onready var _run_blend_pos : String = "parameters/Run/blend_position";
@onready var _attack_blend_pos : String = "parameters/Attack/blend_position";
#@onready var _state_machine := %"StateMachine"

var _last_input_direction : Vector2;

func _ready() -> void:
	_state_machine.init(self, _animationState)
	

func _unhandled_input(event: InputEvent) -> void:
	_state_machine.process_input(event);
	
func _process(delta: float) -> void:
	_state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	_state_machine.process_physics(delta);
	
func player_movement() -> bool:
	return Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right') or Input.is_action_pressed('move_up') or Input.is_action_pressed('move_down')
