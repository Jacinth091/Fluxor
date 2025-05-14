extends Node

@export var initial_state : State;

var _states : Dictionary[String, State] = {};
var _current_state : State = null;

func _ready() -> void:
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child;
			child.Transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.Enter()
		_current_state = initial_state;
		print(_current_state.name);

func _process(delta: float) -> void:
	if _current_state:
		_current_state.Update(delta)
	pass

func _physics_process(delta: float) -> void:
	if _current_state:
		_current_state.Physics_Update(delta)
	pass

func on_child_transition(state: State, new_state_name: String) -> void:
	#local state = idle and the state = idle
	print("Transition signal received: " + new_state_name)  # Debug line
	print("Current State: " + _current_state.name + "\nState: " + state.name)
	if state != _current_state:
		return;
#	It checks if the new state name is in the dictionary and then assign it to the newtate var
	var _new_state = _states.get(new_state_name.to_lower())  # Access by key properly
	if !_new_state:
		return;
	print("Current State: " + _current_state.name + "\nNew State: " + _new_state.name)
	
	if _current_state:
		_current_state.Exit();

	_new_state.Enter();
	_current_state = _new_state;
	pass
