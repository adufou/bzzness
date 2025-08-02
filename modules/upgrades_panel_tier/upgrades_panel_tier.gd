extends VBoxContainer
class_name UpgradesPanelTier

var upgrade_item_scene: PackedScene
var upgrade_tier: int

func _ready() -> void:
	instantiate_upgrade_items()
	
	%TierLabel.text = _prettify_tier()
	
func _prettify_tier() -> String:
	return "Tier " + str(upgrade_tier)

func instantiate_upgrade_items() -> void:
	for upgrade_name: String in Upgrades.UpgradesEnum:
		if Upgrades.get_upgrade_tier(Upgrades.UpgradesEnum[upgrade_name]) != upgrade_tier:
			continue
		
		var upgrade_item: UpgradeItem = upgrade_item_scene.instantiate()
		upgrade_item.upgrade_enum = Upgrades.UpgradesEnum[upgrade_name]
		%UpgradesVBoxContainer.add_child(upgrade_item)
