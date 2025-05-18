class_name HurtboxComponent extends Area2D

signal received_attack(attack: AttackComponent)

@export var health : HealthComponent;

func _ready() -> void:
	connect("area_entered", on_area_entered)

func on_area_entered(hitbox : HitboxComponent)->void:
	if not hitbox or not health:
		return

	var attack = hitbox.attack

	# Defensive check: access damage through get() to bypass type checks
	if attack:
		health.take_damage(attack.attack_damage, attack)
		received_attack.emit(attack)
	else:
		print("Error: attack missing damage property or is invalid")

	#if not hitbox or not health:
		#return
	#print("hitbox.attack class:", hitbox.attack.get_class())
	#print("Is AttackComponent?", hitbox.attack is AttackComponent)
	#var attack = hitbox.attack as AttackComponent
	#print("hitbox.attack class:", attack.get_class())
	#print("Is AttackComponent?", hitbox.attack is AttackComponent)
	#if attack and (attack as AttackComponent):
		#health.take_damage(attack.damage, attack)
		#received_attack.emit(attack)
	#else:
		#print("Error: hitbox.attack is not an AttackComponent")
