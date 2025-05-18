class_name WeaponStateMachine
extends Node

@export var initial_state: WeaponState = null
var _current_state: WeaponState = null
#var _weapon: Node2D

func init(parent: Node2D, player : CharacterBody2D = null) -> void:
	for child in get_children():
		if child is WeaponState:
			child._parent = parent
			child._player = player
		else:
			push_warning("Child %s is not a WeaponState" % child.name)
	change_state(initial_state)

func change_state(new_state: WeaponState) -> void:
	if _current_state:
		_current_state.exit()
	_current_state = new_state
	if _current_state:
		_current_state.enter()

func process_frame(delta: float) -> void:
	if _current_state:
		var new_state = _current_state.process_frame(delta)
		if new_state:
			change_state(new_state)

func process_input(event: InputEvent) -> void:
	if _current_state:
		var new_state = _current_state.process_input(event)
		if new_state:
			change_state(new_state)
