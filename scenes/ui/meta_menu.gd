extends CanvasLayer

@onready var grid_container = %GridContainer

@export var upgrades: Array[MetaUpgrade] = []

var meta_upgrade_card_scene = preload("res://scenes/ui/meta_upgrade_card.tscn")


func _ready():
	for upgrade in upgrades:
		var meta_upgrade_card = meta_upgrade_card_scene.instantiate()
		grid_container.add_child(meta_upgrade_card)
		meta_upgrade_card.set_meta_upgrade(upgrade)
