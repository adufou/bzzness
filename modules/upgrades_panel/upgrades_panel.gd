extends Control

signal on_close_upgrades_panel

func _ready() -> void:
	GameState.on_update_tier_1_upgrade_level_bees_carry_capacity.connect(update_tier_1_upgrade_level_bees_carry_capacity)
	GameState.on_update_tier_1_upgrade_level_bees_lifetime.connect(update_tier_1_upgrade_level_bees_lifetime)
	GameState.on_update_tier_1_upgrade_level_bees_speed.connect(update_tier_1_upgrade_level_bees_speed)
	GameState.on_update_tier_1_upgrade_level_eggs_auto_spawn_rate.connect(update_tier_1_upgrade_level_eggs_auto_spawn_rate)
	GameState.on_update_tier_1_upgrade_level_flowers_spawn_rate.connect(update_tier_1_upgrade_level_flowers_spawn_rate)

	update_tier_1_upgrade_level_bees_carry_capacity()
	update_tier_1_upgrade_level_bees_lifetime()
	update_tier_1_upgrade_level_bees_speed()
	update_tier_1_upgrade_level_eggs_auto_spawn_rate()
	update_tier_1_upgrade_level_flowers_spawn_rate()

func update_tier_1_upgrade_level_bees_carry_capacity():
	var level: int = GameState.tier_1_upgrade_level_bees_carry_capacity
	%Tier1BeeCarryCapacityLevelLabel.text = "Lv. " + str(level)
	%Tier1BeeCarryCapacityEffectLabel.text = "+" + str((level * 0.1) * 100) + "%"

func update_tier_1_upgrade_level_bees_lifetime():
	var level: int = GameState.tier_1_upgrade_level_bees_lifetime
	%Tier1BeeLifetimeLevelLabel.text = "Lv. " + str(level)
	%Tier1BeeLifetimeEffectLabel.text = "+" + str((level * 0.1) * 100) + "%"

func update_tier_1_upgrade_level_bees_speed():
	var level: int = GameState.tier_1_upgrade_level_bees_speed
	%Tier1BeeSpeedLevelLabel.text = "Lv. " + str(level)
	%Tier1BeeSpeedEffectLabel.text = "+" + str((level * 0.1) * 100) + "%"

func update_tier_1_upgrade_level_eggs_auto_spawn_rate():
	var level: int = GameState.tier_1_upgrade_level_eggs_auto_spawn_rate
	%Tier1EggAutoSpawnRateLevelLabel.text = "Lv. " + str(level)
	%Tier1EggAutoSpawnRateEffectLabel.text = "+" + str((level * 0.1) * 100) + "%"

func update_tier_1_upgrade_level_flowers_spawn_rate():
	var level: int = GameState.tier_1_upgrade_level_flowers_spawn_rate
	%Tier1FlowerSpawnRateLevelLabel.text = "Lv. " + str(level)
	%Tier1FlowerSpawnRateEffectLabel.text = "+" + str((level * 0.1) * 100) + "%"

func _on_close_upgrades_panel_button_pressed() -> void:
	on_close_upgrades_panel.emit()

func _on_tier_1_bee_carry_capacity_button_pressed() -> void:
	GameState.tier_1_upgrade_level_bees_carry_capacity += 1
	print_debug(GameState.tier_1_upgrade_level_bees_carry_capacity)

func _on_tier_1_bee_lifetime_button_pressed() -> void:
	GameState.tier_1_upgrade_level_bees_lifetime += 1
	print_debug(GameState.tier_1_upgrade_level_bees_lifetime)

func _on_tier_1_bee_speed_button_pressed() -> void:
	GameState.tier_1_upgrade_level_bees_speed += 1
	print_debug(GameState.tier_1_upgrade_level_bees_speed)

func _on_tier_1_egg_auto_spawn_rate_button_pressed() -> void:
	GameState.tier_1_upgrade_level_eggs_auto_spawn_rate += 1
	print_debug(GameState.tier_1_upgrade_level_eggs_auto_spawn_rate)

func _on_tier_1_flower_spawn_rate_button_pressed() -> void:
	GameState.tier_1_upgrade_level_flowers_spawn_rate += 1
	print_debug(GameState.tier_1_upgrade_level_flowers_spawn_rate)
