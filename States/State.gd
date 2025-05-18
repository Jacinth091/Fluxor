class_name State
extends Node

# State configuration
@export var animation_name: String
@export var move_speed := 80
@export var acceleration: int = 300
@export var friction: int = 500

# Get gravity from project settings
var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var _parent: CharacterBody2D
func _get_animation_player() -> AnimationPlayer:
	return _parent.get_node("AnimationPlayer")
func _get_sprite() -> Sprite2D:
	return _parent.get_node("Sprite2D")
func _get_move_component() -> MoveComponent:
	return _parent.get_node("MoveComponent")
func _get_health_component() -> HealthComponent:
	return _parent.get_node("HealthComponent")
func _get_attack_component() -> AttackComponent:
	return _parent.get_node("AttackComponent")
func _get_hitbox_component() -> HitboxComponent:
	return _parent.get_node("HitboxComponent")
func _get_hurtbox_component() -> HurtboxComponent:
	return _parent.get_node("HurtboxComponent")

func enter() -> void:
	if animation_name:
		_get_animation_player().play(animation_name)
	
	var health_component = _get_health_component();
	if health_component:
		health_component.health_changed.connect(_on_health_changed)
		health_component.max_health_changed.connect(_on_max_health_changed)
		health_component.health_depleted.connect(on_health_depleted)
		health_component.damage_taken.connect(_on_damage_taken)
	# Hurtbox component signal
	var hurtbox_component = _get_hurtbox_component()
	if hurtbox_component:
		hurtbox_component.received_attack.connect(_on_received_attack)
	

func exit() -> void:
	var health_component = _get_health_component();
	if health_component:
		health_component.health_changed.disconnect(_on_health_changed)
		health_component.max_health_changed.disconnect(_on_max_health_changed)
		health_component.health_depleted.disconnect(on_health_depleted)
		health_component.damage_taken.disconnect(_on_damage_taken)
	
	var hurtbox_component = _get_hurtbox_component()
	if hurtbox_component:
		hurtbox_component.received_attack.disconnect(_on_received_attack)
# Virtual methods for state behavior
func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

# Move Component Helper methods
func get_movement_direction() -> Vector2:
	return  _get_move_component().get_movement_direction()

func wants_to_dash() -> bool:
	return _get_move_component().wants_to_dash()

# Attack Component Methods
func wants_to_attack() -> bool:
	return _get_attack_component().wants_to_attack()


# Health Signal Handlers
func _on_health_changed(new_health: float) -> void: 
	pass
func _on_max_health_changed(new_max_health: float)-> void:
	pass 
func on_health_depleted() -> void:
	pass
func _on_damage_taken(amount: float, attack: AttackComponent) -> void:
	pass 
	
# Hurtbox Signal Handlers
func _on_received_attack(attack: AttackComponent) -> void:
	pass
