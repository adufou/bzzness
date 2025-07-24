extends Control

signal on_close_upgrades_panel

func _ready() -> void:
	GameState.on_update_tier_1_upgrade_level_bee_carry_capacity.connect(update_tier_1_upgrade_level_bee_carry_capacity)
	GameState.on_update_tier_1_upgrade_level_bee_lifetime.connect(update_tier_1_upgrade_level_bee_lifetime)
	GameState.on_update_tier_1_upgrade_level_bee_speed.connect(update_tier_1_upgrade_level_bee_speed)

	update_tier_1_upgrade_level_bee_carry_capacity(GameState.tier_1_upgrade_level_bee_carry_capacity)
	update_tier_1_upgrade_level_bee_lifetime(GameState.tier_1_upgrade_level_bee_lifetime)
	update_tier_1_upgrade_level_bee_speed(GameState.tier_1_upgrade_level_bee_speed)

func update_tier_1_upgrade_level_bee_carry_capacity(new_level: int):
	%Tier1BeeCarryCapacityLevelLabel.text = "Lv. " + str(new_level)
	%Tier1BeeCarryCapacityEffectLabel.text = "+" + str((new_level * 0.1) * 100) + "%"

func update_tier_1_upgrade_level_bee_lifetime(new_level: int):
	%Tier1BeeLifetimeLevelLabel.text = "Lv. " + str(new_level)
	%Tier1BeeLifetimeEffectLabel.text = "+" + str((new_level * 0.1) * 100) + "%"

func update_tier_1_upgrade_level_bee_speed(new_level: int):
	%Tier1BeeSpeedLevelLabel.text = "Lv. " + str(new_level)
	%Tier1BeeSpeedEffectLabel.text = "+" + str((new_level * 0.1) * 100) + "%"

func _on_close_upgrades_panel_button_pressed() -> void:
	on_close_upgrades_panel.emit()

func _on_tier_1_bee_carry_capacity_button_pressed() -> void:
	GameState.tier_1_upgrade_level_bee_carry_capacity += 1

func _on_tier_1_bee_lifetime_button_pressed() -> void:
	GameState.tier_1_upgrade_level_bee_lifetime += 1

func _on_tier_1_bee_speed_button_pressed() -> void:
	GameState.tier_1_upgrade_level_bee_speed += 1
