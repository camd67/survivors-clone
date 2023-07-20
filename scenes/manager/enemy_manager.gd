extends Node

# longest window size (640) / 2 with a little buffer
const SPAWN_RADIUS = 320 + 20

@export var basic_enemy_scene: PackedScene

func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	# Spawn an enemy in a random location around a big circle around the player
	# That way the player won't see the spawn
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy = basic_enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
