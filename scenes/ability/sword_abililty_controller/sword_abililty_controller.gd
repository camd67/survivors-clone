extends Node

const MAX_RANGE = 150

@export var sword_abililty: PackedScene
var damage = 5
var base_wait_time: float

# Called when the node enters the scene tree for the first time.
func _ready():
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	# Get all the enemies within range
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D): 
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	if enemies.size() == 0:
		return
	
	# Sort to figure out who's closest
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	var sword = sword_abililty.instantiate() as SwordAbililty
	player.get_parent().add_child(sword)
	sword.hitbox_component.damage = damage
	sword.global_position = enemies[0].global_position
	# give a little random unit vector and move a little way away from that
	sword.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = enemies[0].global_position - sword.global_position
	sword.rotation = enemy_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		return
	
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	$Timer.start()
