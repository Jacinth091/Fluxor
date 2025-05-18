


#@export var hitbox: Area2D
#@export var attack_animation: String = "attack"
#@export var attack_sound: AudioStream
### Visual effect (e.g., slash particles)
#@export var hit_effect: PackedScene
class_name AttackComponent
extends Node2D

@export var attack_damage : float
@export var knockback_damage : float
@export var knockback_force: float = 200.0
@export var cooldown: float = 1.0
@export var range: float = 100.0
var attack_position: Vector2

# Internal variables
var _can_attack: bool = true
var _cooldown_timer: float = 0.0
var _target: Node2D = null

func wants_attack() -> bool:
	var key_name = ""
	var prompt_action = "attack"

	if InputMap.has_action(prompt_action):
		var events = InputMap.action_get_events(prompt_action)
		if events.size() > 0:
			var key_action = events[0]
			if key_action is InputEventKey:
				key_name =  OS.get_keycode_string(key_action.physical_keycode)
			elif key_action is InputEventMouseButton:
				key_name = "Mouse Button " + str(key_action.button_index)
			else:
				key_name = "Unknown input event"

	
	var pressed = Input.is_action_pressed(prompt_action)
	if pressed:
		print("Attack button just pressed:", key_name)
	return pressed


##region ===== CORE FUNCTIONS =====
#func try_attack(target: Node2D) -> bool:
	#if not _can_attack:
		#return false
	#if not _is_target_valid(target):
		#return false
	#
	#_target = target
	#_start_attack()
	#return true
#
#func _start_attack():
	#_can_attack = false
	#_cooldown_timer = cooldown
	#
	## Play animation (if available)
	#if get_parent().has_method("play_animation"):
		#get_parent().play_animation(attack_animation)
	#
	## Play sound (if available)
	#if attack_sound and get_parent().has_method("play_sound"):
		#get_parent().play_sound(attack_sound)
	#
	## Enable hitbox (if using one)
	#if hitbox:
		#hitbox.monitoring = true
		#await get_tree().create_timer(0.2).timeout  # Small delay to prevent multi-hits
		#hitbox.monitoring = false
#
#func _process(delta: float):
	#if not _can_attack:
		#_cooldown_timer -= delta
		#if _cooldown_timer <= 0.0:
			#_can_attack = true
##endregion
#
##region ===== HELPER FUNCTIONS =====
#func _is_target_valid(target: Node2D) -> bool:
	#return (
		#target != null and
		#target.is_inside_tree() and
		#get_parent().global_position.distance_to(target.global_position) <= range
	#)
#
#func _on_hitbox_body_entered(body: Node2D):
	#if not body.has_method("take_damage"):
		#return
	#
	#body.take_damage(damage)
	#_apply_knockback(body)
	#
	## Spawn hit effect (e.g., blood, sparks)
	#if hit_effect:
		#var effect = hit_effect.instantiate()
		#effect.global_position = body.global_position
		#get_tree().current_scene.add_child(effect)
#
#func _apply_knockback(target: Node2D):
	#if knockback_force <= 0.0 or not target.has_method("apply_force"):
		#return
	#
	#var direction = (target.global_position - get_parent().global_position).normalized()
	#target.apply_force(direction * knockback_force)
##endregion
#
##region ===== INITIALIZATION =====
#func _ready():
	#if hitbox:
		#hitbox.monitoring = false
		#hitbox.body_entered.connect(_on_hitbox_body_entered)
##endregion
