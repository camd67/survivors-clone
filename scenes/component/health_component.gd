extends Node
class_name HealthComponent

signal died
signal health_changed
signal health_decreased

@export var max_health: float = 10

var current_health

func _ready():
	current_health = max_health


func damage(damage_value: float) -> void:
	current_health = clamp(current_health - damage_value, 0, max_health)
	health_changed.emit()
	if damage_value > 0:
		health_decreased.emit()
	Callable(check_death).call_deferred()


func heal(heal_amount: float) -> void:
	damage(-heal_amount)


func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()


func get_health_percent() -> float:
	if max_health <= 0:
		return 0
	
	return min(current_health / max_health, 1)
