class_name Player extends CharacterBody2D

@export var sprite : Sprite2D
 
var can_dodge : bool = false
@onready var state_machine: StateMachine = %StateMachine


func _ready() -> void:
	state_machine.init(self)
	pass
#
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event);
	pass
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	pass
	#
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta);
	sprite_flip();
	pass

func sprite_flip()-> void:
	var mouse_position := get_global_mouse_position()
	if mouse_position.x - global_position.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func player_dash()-> void :
	pass
