extends CharacterBody2D
class_name Enemy

var _move_speed : float = 1.7
const MAX_SPEED : int = 20
const ACCELERATION : int = 400
const FRICTION : int = 400
var enemy_movement := Vector2.ZERO

@onready var _animationPlayer: AnimationPlayer = %AnimationPlayer
@onready var _animationTree : AnimationTree = %AnimationTree
@onready var _animationState = _animationTree.get("parameters/playback")
@onready var _sprite : Sprite2D = %Sprite2D


func _physics_process(delta: float) -> void:
	# Set the movement mode
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
	
	# Apply movement based on current movement direction
	if enemy_movement != Vector2.ZERO:
		_animationState.travel("Move")
		velocity = velocity.move_toward(enemy_movement * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	# Flip the sprite based on the movement direction
	if velocity.x > 0:
		_sprite.flip_h = false
	else:
		_sprite.flip_h = true
	
	# Apply the movement
	move_and_slide()
