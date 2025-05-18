class_name HitboxComponent extends Area2D

#@export var health_component : HealthComponent

@export var attack : AttackComponent : set = set_attack, get = get_attack;	
func set_attack(value : AttackComponent) -> void:
	attack = value

func get_attack() -> AttackComponent:
	return attack
