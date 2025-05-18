class_name Sword
extends Node2D

@onready var _weapon_sprite: Sprite2D = %WeaponSprite
@onready var _weapon_pivot: Node2D = %WeaponPivot
@onready var _weapon_marker: Marker2D = $WeaponSprite/WeaponMarker

# Optional: Smoothing control
@export var rotation_speed: float = 15.0
var target_rotation: float = 0.0

func _process(delta: float) -> void:
	#var mouse_pos = get_global_mouse_position()
	#var dir = mouse_pos - _weapon_pivot.global_position
	#
	## Flip sprite based on mouse direction
	#_weapon_sprite.scale.x = -1 if dir.x < 0 else 1
	#_weapon_sprite.scale.y = -1 if dir.y < 0 else 1
	#
	#
	## Calculate target rotation normally
	#target_rotation = dir.angle()
	#
	## Rotate the pivot smoothly to face mouse
	#_weapon_pivot.rotation = lerp_angle(_weapon_pivot.rotation, target_rotation, rotation_speed * delta)
	pass
	#var mouse_pos = get_global_mouse_position()
	#var marker_pos = _weapon_marker.global_position
	#
	## Direction from marker to mouse
	#var aim_direction = mouse_pos - marker_pos
	#
	## Flip sprite based on direction
	#if aim_direction.x < 0:
		#_weapon_sprite.scale.x = -abs(_weapon_sprite.scale.x)
	#else:
		#_weapon_sprite.scale.x = abs(_weapon_sprite.scale.x)
	#
	## Calculate rotation from marker to mouse
	#var target_rotation = marker_pos.direction_to(mouse_pos).angle()
	#
	## Convert to local rotation
	#target_rotation -= global_rotation
	#
	## Rotate the sprite (smoothed)
	#_weapon_sprite.rotation = lerp_angle(_weapon_sprite.rotation, target_rotation, rotation_speed * delta)
