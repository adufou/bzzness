extends Control

@export var upgrade_panel_item_scene: PackedScene
@export var upgrade_panel_tier_scene: PackedScene

signal on_close_upgrades_panel

var _upgrades_panel_tiers: Dictionary[int, UpgradesPanelTier] = {}

func _ready() -> void:
	instantiate_upgrade_tiers()

func instantiate_upgrade_tiers() -> void:
	for upgrade_name: String in Upgrades.UpgradesEnum:
		var upgrade_enum: Upgrades.UpgradesEnum = Upgrades.UpgradesEnum[upgrade_name]
		var upgrade_tier: int = Upgrades.get_upgrade_tier(upgrade_enum)
		
		if not _upgrades_panel_tiers.has(upgrade_tier):
			var upgrades_panel_tier: UpgradesPanelTier = upgrade_panel_tier_scene.instantiate()
			upgrades_panel_tier.upgrade_tier = upgrade_tier
			upgrades_panel_tier.upgrade_item_scene = upgrade_panel_item_scene
			
			%UpgradeTiersVBoxContainer.add_child(upgrades_panel_tier)
			
			_upgrades_panel_tiers[upgrade_tier] = upgrades_panel_tier

func _on_close_upgrades_panel_button_pressed() -> void:
	on_close_upgrades_panel.emit()
