extends Node
class_name Global

var player : CharacterBody2D
signal player_ready(player: CharacterBody2D)
#func _ready():
	## Assuming you set the player at some point
	##player = get_node("Player")  # Replace this with your actual way of assigning the player
	#
	## Emit the signal when the player is assigned
	#if player:
		#emit_signal("player_assigned", player)
