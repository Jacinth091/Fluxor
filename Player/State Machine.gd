class_name StateMachine
extends Node

@export var initial_state : State = null;
var _current_state : State = null;


func init(parent: CharacterBody2D) -> void:
	for child in get_children():
		if child is State:
			child._parent = parent
		else:
			push_warning("StateMachine child %s is not a State node" % child.name)
	change_state(initial_state)


func change_state(new_state : State)-> void:
	if _current_state:
		_current_state.exit();
	
	_current_state = new_state;
	_current_state.enter();

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
