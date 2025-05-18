class_name HealthComponent
extends Node


signal max_health_changed(diff: float)
signal health_changed(diff: float)
signal health_depleted
signal damage_taken(amount: float, attack: AttackComponent)

@export var max_health: float = 10.0 : set = set_max_health, get = get_max_health
@export var immortality: bool = false : set = set_immortality, get = get_immortality
@onready var health: float = max_health : set = set_health, get = get_health
var immortality_timer: Timer = null



func take_damage(amount: float, attack: AttackComponent = null) -> void:
	if immortality:
		return
	var old_health = health
	set_health(health - amount)  # This triggers health_changed
	# Only emit if damage actually occurred
	if health < old_health:
		damage_taken.emit(old_health - health, attack)
	print(self.get_parent().name + ": ", health)

func set_max_health(value: float):
	var clamped_value = 1 if value <= 0 else value
	
	if not clamped_value == max_health:
		var difference = clamped_value - max_health
		max_health = value
		max_health_changed.emit(difference)
		
		if health > max_health:
			health = max_health


func get_max_health() -> float:
	return max_health


func set_immortality(value: bool):
	immortality = value


func get_immortality() -> bool:
	return immortality


func set_temporary_immortality(time: float):
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)
	
	if immortality_timer.timeout.is_connected(set_immortality):
		immortality_timer.timeout.disconnect(set_immortality)
	
	immortality_timer.set_wait_time(time)
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start()


func set_health(value: float):
	if value < health and immortality:
		return
	
	var clamped_value = clampi(value, 0, max_health)
	
	if clamped_value != health:
		var difference = clamped_value - health
		health = clamped_value;
		health_changed.emit(difference)
		
		if health == 0:
			health_depleted.emit()
			self.get_parent().queue_free()


func get_health():
	return health
