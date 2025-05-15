class_name Player extends CharacterBody2D

# Base States, Animation and Sprite
@onready var _base_state_machine := %BaseStateMachine
@onready var _base_animation_player := %BaseAnimations;
@onready var _player_sprite := %PlayerSprite;

# Weapon State, Animation and Sprite
@onready var _weapon_state_machine := %WeaponStateMachine
@onready var _weapon_animation_player := %WeaponAnimations
@onready var _weapon_sprite := %Weapon.get_node("%WeaponSprite")



@onready var _move_component := %MoveComponent;

var _last_input_direction := Vector2.RIGHT  # Default facing direction

func _ready() -> void:
	_base_state_machine.init(self as CharacterBody2D, _base_animation_player, _player_sprite, _move_component)
	_weapon_state_machine.init(self as CharacterBody2D, _weapon_animation_player, _weapon_sprite, _move_component)
	

func _unhandled_input(event: InputEvent) -> void:
	_base_state_machine.process_input(event);
	_weapon_state_machine.process_input(event);
	
func _process(delta: float) -> void:
	_base_state_machine.process_frame(delta)
	_weapon_state_machine.process_frame(delta);
	
func _physics_process(delta: float) -> void:
	_base_state_machine.process_physics(delta);
	_weapon_state_machine.process_physics(delta);
	
