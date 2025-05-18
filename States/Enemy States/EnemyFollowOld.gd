extends State
class_name EnemyFollow

@export var enemy : CharacterBody2D
var target : Player
#@export var move_speed := 10.0


func Enter() -> void:
	if !enemy: return



func Physics_Update(delta: float) -> void:
	if !target:
		print("No target, returning to idle state.")
		Transitioned.emit(self, "EnemyIdle") 
		return
	
	var _direction := target.global_position - enemy.global_position
	#var _new_position := _direction.normalized() * move_speed
	var _new_position := _direction.normalized()
	
	var _distance := _direction.length()

	if _distance > 25:
		enemy.enemy_movement = _new_position 
	else:
		enemy.enemy_movement = Vector2.ZERO 

	if _distance > 100:
		print("Player too far, stopping chase.")
		target = null  # Reset the target when player is too far
		Transitioned.emit(self, "EnemyIdle")  
		return
	
	# Print debug info
	#print("Enemy Position:", enemy.global_position)
	#print("Player Position:", target.global_position)
	#print("Direction:", _direction)
	#print("Distance:", _distance)

# Called when an object enters the follow area (like the player)
func _on_follow_area_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
		print("Player detected, following now.")
	pass
