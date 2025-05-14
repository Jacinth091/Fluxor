extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
#@export var move_speed := 10.0

var _move_direction : Vector2 = Vector2.ZERO
var _wander_time : float = 0.0

# Randomize the direction and set the wander time
func randomize_number() -> void:
	_move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	_wander_time = randf_range(1, 3)  # Randomize wander time between 1 to 3 seconds

# Called when entering this state
func Enter() -> void:
	print("Entered " + self.name + " state!")
	randomize_number()  # Set initial wandering direction and time
	pass
	
# Called on each frame update
func Update(delta: float) -> void:
	# Decrease wander time
	if _wander_time > 0:
		_wander_time -= delta
	else:
		# Once wander time is up, randomize the direction again
		randomize_number()
	
	# Optionally, handle idle animations or behaviors here
	pass

# Physics update happens every physics frame
func Physics_Update(delta: float) -> void:
	if enemy:
		enemy.enemy_movement = _move_direction
		#enemy.enemy_movement = _move_direction * move_speed
	

func _on_follow_area_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player detected, transitioning to follow state.")
		Transitioned.emit(self, "EnemyFollow")  
	pass
