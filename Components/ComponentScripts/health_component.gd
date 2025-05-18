class_name healthcompo extends Node2D

@export var MAX_HEALTH := 10.0
var health : float

func _ready()-> void:
	health = MAX_HEALTH;
	pass

func damage(attack : Attack) -> void:
	health -= attack.attack_damage
	pass;
	
	if health  <= 0:
		get_parent().queue_free();
