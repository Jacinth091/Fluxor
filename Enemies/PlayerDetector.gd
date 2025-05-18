class_name PlayerDetector
extends Area2D

signal player_detected(player)
signal player_lost()

var player: CharacterBody2D = null

func _ready():
	# Automatically connect Area2D signals
	#connect("body_entered", Callable(self, "_on_body_entered"))
	#connect("body_exited", Callable(self, "_on_body_exited"))
	connect("body_entered", Callable(self, "_on_follow_area_body_entered"))
	connect("body_exited", Callable(self, "_on_follow_area_body_exited"))
#a
		
func _on_follow_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body as CharacterBody2D
		print("Player detected, following now. Yes Daddy")
		emit_signal("player_detected", body)
func _on_follow_area_body_exited(body: Node2D) -> void:
	if body == player:
		print("Player left the area. No Daddy 😢")
		player = null
		emit_signal("player_lost")
