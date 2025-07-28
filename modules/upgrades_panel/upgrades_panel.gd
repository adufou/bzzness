extends Control

signal on_close_upgrades_panel

var is_tier_1_upgrade_level_bees_lifetime_button_pressed: bool = false
var is_tier_1_upgrade_level_bees_speed_button_pressed: bool = false
var is_tier_1_upgrade_level_eggs_auto_spawn_rate_button_pressed: bool = false
var is_tier_1_upgrade_level_flowers_spawn_rate_button_pressed: bool = false
var is_tier_1_upgrade_level_honey_factory_max_pollen_button_pressed: bool = false
var is_tier_1_upgrade_level_honey_factory_production_rate_button_pressed: bool = false

func _ready() -> void:
	GameState.on_update_tier_1_upgrade_level_bees_lifetime.connect(update_tier_1_upgrade_level_bees_lifetime)
	GameState.on_update_tier_1_upgrade_level_bees_speed.connect(update_tier_1_upgrade_level_bees_speed)
	GameState.on_update_tier_1_upgrade_level_eggs_auto_spawn_rate.connect(update_tier_1_upgrade_level_eggs_auto_spawn_rate)
	GameState.on_update_tier_1_upgrade_level_flowers_spawn_rate.connect(update_tier_1_upgrade_level_flowers_spawn_rate)
	GameState.on_update_tier_1_upgrade_level_honey_factory_max_pollen.connect(update_tier_1_upgrade_level_honey_factory_max_pollen)
	GameState.on_update_tier_1_upgrade_level_honey_factory_production_rate.connect(update_tier_1_upgrade_level_honey_factory_production_rate)

	update_tier_1_upgrade_level_bees_lifetime()
	update_tier_1_upgrade_level_bees_speed()
	update_tier_1_upgrade_level_eggs_auto_spawn_rate()
	update_tier_1_upgrade_level_flowers_spawn_rate()
	update_tier_1_upgrade_level_honey_factory_max_pollen()
	update_tier_1_upgrade_level_honey_factory_production_rate()

func _process(delta: float) -> void:
	if is_tier_1_upgrade_level_bees_lifetime_button_pressed:
		GameState.tier_1_upgrade_level_bees_lifetime += 1
	if is_tier_1_upgrade_level_bees_speed_button_pressed:
		GameState.tier_1_upgrade_level_bees_speed += 1
	if is_tier_1_upgrade_level_eggs_auto_spawn_rate_button_pressed:
		GameState.tier_1_upgrade_level_eggs_auto_spawn_rate += 1
	if is_tier_1_upgrade_level_flowers_spawn_rate_button_pressed:
		GameState.tier_1_upgrade_level_flowers_spawn_rate += 1
	if is_tier_1_upgrade_level_honey_factory_max_pollen_button_pressed:
		GameState.tier_1_upgrade_level_honey_factory_max_pollen += 1
	if is_tier_1_upgrade_level_honey_factory_production_rate_button_pressed:
		GameState.tier_1_upgrade_level_honey_factory_production_rate += 1

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

func update_tier_1_upgrade_level_honey_factory_max_pollen():
	var level: int = GameState.tier_1_upgrade_level_honey_factory_max_pollen
	%Tier1HoneyFactoryMaxPollenLevelLabel.text = "Lv. " + str(level)
	%Tier1HoneyFactoryMaxPollenEffectLabel.text = "+" + str((level * 0.1) * 100) + "%"

func update_tier_1_upgrade_level_honey_factory_production_rate():
	var level: int = GameState.tier_1_upgrade_level_honey_factory_production_rate
	%Tier1HoneyFactoryProductionRateLevelLabel.text = "Lv. " + str(level)
	%Tier1HoneyFactoryProductionRateEffectLabel.text = "+" + str((level * 0.1) * 100) + "%"

func _on_close_upgrades_panel_button_pressed() -> void:
	on_close_upgrades_panel.emit()

func _on_tier_1_bee_lifetime_button_button_down() -> void:
	is_tier_1_upgrade_level_bees_lifetime_button_pressed = true
	
func _on_tier_1_bee_lifetime_button_button_up() -> void:
	is_tier_1_upgrade_level_bees_lifetime_button_pressed = false
	
func _on_tier_1_bee_speed_button_button_down() -> void:
	is_tier_1_upgrade_level_bees_speed_button_pressed = true
	
func _on_tier_1_bee_speed_button_button_up() -> void:
	is_tier_1_upgrade_level_bees_speed_button_pressed = false

func _on_tier_1_egg_auto_spawn_rate_button_button_down() -> void:
	is_tier_1_upgrade_level_eggs_auto_spawn_rate_button_pressed = true

func _on_tier_1_egg_auto_spawn_rate_button_button_up() -> void:
	is_tier_1_upgrade_level_eggs_auto_spawn_rate_button_pressed = false

func _on_tier_1_flower_spawn_rate_button_button_down() -> void:
	is_tier_1_upgrade_level_flowers_spawn_rate_button_pressed = true

func _on_tier_1_flower_spawn_rate_button_button_up() -> void:
	is_tier_1_upgrade_level_flowers_spawn_rate_button_pressed = false

func _on_tier_1_honey_factory_max_pollen_button_button_down() -> void:
	is_tier_1_upgrade_level_honey_factory_max_pollen_button_pressed = true

func _on_tier_1_honey_factory_max_pollen_button_button_up() -> void:
	is_tier_1_upgrade_level_honey_factory_max_pollen_button_pressed = false

func _on_tier_1_honey_factory_production_rate_button_button_down() -> void:
	is_tier_1_upgrade_level_honey_factory_production_rate_button_pressed = true

func _on_tier_1_honey_factory_production_rate_button_button_up() -> void:
	is_tier_1_upgrade_level_honey_factory_production_rate_button_pressed = false
