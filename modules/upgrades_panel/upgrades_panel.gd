extends Control

@export var upgrade_item_scene: PackedScene

signal on_close_upgrades_panel

var is_tier_1_upgrade_level_bees_lifetime_button_pressed: bool = false
var is_tier_1_upgrade_level_bees_speed_button_pressed: bool = false
var is_tier_1_upgrade_level_eggs_auto_spawn_rate_button_pressed: bool = false
var is_tier_1_upgrade_level_flowers_spawn_rate_button_pressed: bool = false
var is_tier_1_upgrade_level_honey_factory_production_rate_button_pressed: bool = false

func _ready() -> void:
	instantiate_upgrade_items()

func instantiate_upgrade_items() -> void:
	for upgrade_name: String in Upgrades.UpgradesEnum:
		var upgrade_item: UpgradeItem = upgrade_item_scene.instantiate()
		upgrade_item.upgrade_enum = Upgrades.UpgradesEnum[upgrade_name]
		%Tier1VBoxContainer.add_child(upgrade_item)

func _on_close_upgrades_panel_button_pressed() -> void:
	on_close_upgrades_panel.emit()
