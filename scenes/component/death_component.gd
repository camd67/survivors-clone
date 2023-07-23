extends Node2D

@export var health_component: HealthComponent
@export var sprite: Sprite2D

func _ready():
	health_component.died.connect(on_died)
	$GPUParticles2D.texture = sprite.texture


func on_died():
	if owner == null || not owner is Node2D:
		return
	
	var spawn_position = owner.global_position
	
	# After removing ourself we'll lose access to the tree
	var entities = get_tree().get_first_node_in_group("entities_layer")
	
	# Remove ourself and attach us somewhere more permanent
	get_parent().remove_child(self)
	entities.add_child(self)
	global_position = spawn_position
	$AnimationPlayer.play("default")
