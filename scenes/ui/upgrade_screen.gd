extends CanvasLayer
class_name UpgradeScreen

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container = %CardContainer

func _ready():
	get_tree().paused = true

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	for upgrade in upgrades:
		var card = upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(card)
		card.set_abililty_upgrade(upgrade)
		card.selected.connect(on_upgrade_selected.bind(upgrade))


func on_upgrade_selected(upgrade: AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
