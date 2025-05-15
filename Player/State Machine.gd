class_name StateMachine
extends Node

@export var initial_state : State = null;
var _current_state : State = null;


func init(parent: CharacterBody2D, animation_player: AnimationPlayer, sprite: Sprite2D, move_component : MoveComponent) -> void:
	for child in get_children():
		if child is State:  # Only process nodes that inherit from State
			child._parent = parent
			child._animation_player = animation_player
			child._sprite = sprite;
		else:
			push_warning("StateMachine child %s is not a State node" % child.name)
		child._move_component = move_component;
	
	change_state(initial_state)


func change_state(new_state : State)-> void:
	if _current_state:
		_current_state.exit();
	
	_current_state = new_state;
	_current_state.enter();


# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = _current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = _current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = _current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
