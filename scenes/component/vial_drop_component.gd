extends Node

@export_range(0, 1) var drop_percent: float = .5
@export var health_component: HealthComponent

@export var vial_scene: PackedScene


func _ready():
	health_component.died.connect(on_died)


func on_died():
	if randf() > drop_percent:
		return
	
	if vial_scene == null:
		return
	
	if not owner is Node2D:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var vial = vial_scene.instantiate() as Node2D
	owner.get_parent().add_child(vial)
	vial.global_position = spawn_position
