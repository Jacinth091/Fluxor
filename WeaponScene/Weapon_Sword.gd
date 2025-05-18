class_name Weapon_Sword extends Node2D

@onready var _pivot := $Pivot
@export var _current_weapon : Weapon_Resource
@onready var weapon_state_machine: WeaponStateMachine = %WeaponStateMachine
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var _player := get_parent() if get_parent() is CharacterBody2D else null

func _ready() -> void:
	print("Player?: ", _player.name)
	weapon_state_machine.init(self, _player)
	pass
#
func _unhandled_input(event: InputEvent) -> void:
	weapon_state_machine.process_input(event);
	pass
	
func _process(delta: float) -> void:
	weapon_state_machine.process_frame(delta)
	sprite_flip();
	pass
	#
#func _physics_process(delta: float) -> void:
	#weapon_state_machine.process_physics(delta);
#
	#pass


func sprite_flip() -> void:
	var mouse_position := get_global_mouse_position()
	_pivot.look_at(mouse_position)
	#_pivot.position.y = sin(Time.get_ticks_msec() * delta * 0.20) * 10
	# Flip pivot to avoid upside down attacks
	if mouse_position.x - global_position.x < 0:
		_pivot.scale.y = -1
	else:
		_pivot.scale.y = 1
