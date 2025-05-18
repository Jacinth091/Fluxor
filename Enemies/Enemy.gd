extends CharacterBody2D
class_name Enemy

var _move_speed : float = 1.7
const MAX_SPEED : int = 20
const ACCELERATION : int = 400
const FRICTION : int = 400
var enemy_movement := Vector2.ZERO

# Base States, Animation and Sprite
@onready var _base_state_machine := %EnemyStateMachine
@onready var _base_animation_player := %EnemyAnimation;
@onready var _enemy_sprite := %EnemySprite;

@onready var _move_component : EnemyMoveComponent = %EnemyMoveComponent;
@onready var _player_detector : PlayerDetector = %PlayerDetectorArea

var _last_input_direction := Vector2.RIGHT  # Default facing direction

func _ready() -> void:
	_base_state_machine.init(self, _base_animation_player, _enemy_sprite, _move_component)
	_player_detector.connect("player_detected", Callable(_base_state_machine, "on_player_detected"))
	_player_detector.connect("player_lost", Callable(_base_state_machine, "on_player_lost"))

func _on_player_detected(player: CharacterBody2D) -> void:
	# Share detection with state machine
	print("Enemy Script: ", player.name)
	_base_state_machine.on_player_detected(player)

func _on_player_lost() -> void:
	# Notify state machine
	_base_state_machine.on_player_lost()


func _unhandled_input(event: InputEvent) -> void:
	_base_state_machine.process_input(event);

	
func _process(delta: float) -> void:
	_base_state_machine.process_frame(delta)
	
func _physics_process(delta: float) -> void:
	_base_state_machine.process_physics(delta);



#func _physics_process(delta: float) -> void:
	## Set the movement mode
	#motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
	#
	## Apply movement based on current movement direction
	#if enemy_movement != Vector2.ZERO:
		#_animationState.travel("Move")
		#velocity = velocity.move_toward(enemy_movement * MAX_SPEED, ACCELERATION * delta)
	#else:
		#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		#
	## Flip the sprite based on the movement direction
	#if velocity.x > 0:
		#_sprite.flip_h = false
	#else:
		#_sprite.flip_h = true
	#
	## Apply the movement
	#move_and_slide()
