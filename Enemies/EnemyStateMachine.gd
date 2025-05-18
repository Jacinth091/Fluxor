class_name EnemyStateMachine
extends Node

@export var initial_state: EnemyBaseState
var _current_state: EnemyBaseState = null
var _player: CharacterBody2D = null

func init(parent: CharacterBody2D, animation_player: AnimationPlayer, sprite: Sprite2D, move_component: EnemyMoveComponent) -> void:
	for child in get_children():
		if child is EnemyBaseState:
			child.setup(parent, animation_player, sprite, move_component)
		else:
			push_warning("EnemyStateMachine child %s is not an EnemyBaseState" % child.name)
	change_state(initial_state)
	#print("Initial_state: ", initial_state.name)

func change_state(new_state: EnemyBaseState) -> void:
	if not new_state or new_state == _current_state:
		return
	if _current_state:
		_current_state.exit()
	_current_state = new_state
	# Propagate player info to new state
	#if _player:
		#_current_state.player_detected(_player)
	_current_state.enter()


func process_physics(delta: float) -> void:
	if _current_state:
		var new_state = _current_state.process_physics(delta)
		#if new_state and new_state != _current_state:
		if new_state :
			change_state(new_state)

func process_input(event: InputEvent) -> void:
	if _current_state:
		var new_state = _current_state.process_input(event)
		#if new_state and new_state != _current_state:
		if new_state :
			change_state(new_state)

func process_frame(delta: float) -> void:
	if _current_state:
		var new_state = _current_state.process_frame(delta)
		#if new_state and new_state != _current_state:
		if new_state :
			change_state(new_state)

func on_player_detected(player: CharacterBody2D) -> void:
	#_player = player
	if _current_state:
		print("Enemy Script: ", player.name)
		_current_state.player_detected(player)
		print(_current_state._player.name)
	

func on_player_lost() -> void:
	#_player = null
	if _current_state:
		_current_state.player_lost()
