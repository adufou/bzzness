extends Node
class_name Upgrades

enum UpgradesEnum {
	BEE_CARRY_CAPACITY,
	BEE_LIFETIME,
	BEE_SPEED,
	EGG_AUTO_SPAWN_RATE,
	FLOWER_SPAWN_RATE,
	HONEY_FACTORY_MAX_POLLEN,
	HONEY_FACTORY_PRODUCTION_RATE
}

class Upgrade:
	var cost_base: int
	var cost_multiplier: float
	var description: String
	var display_name: String
	var effect_base: float
	var effect_value: float
	var level_max: int
	var tier: int
	var tier_index: int
	
	func _init(upgrade_dict: Dictionary):
		cost_base = upgrade_dict.cost_base
		cost_multiplier = upgrade_dict.cost_multiplier
		description = upgrade_dict.description
		display_name = upgrade_dict.display_name
		effect_base = upgrade_dict.effect_base
		effect_value = upgrade_dict.effect_value
		level_max = upgrade_dict.level_max
		tier = upgrade_dict.tier
		tier_index = upgrade_dict.tier_index

const _UPGRADES: Dictionary = {
	UpgradesEnum.BEE_CARRY_CAPACITY: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the amount of pollen that bees can carry.",
		display_name = "Bee Carry Capacity",
		effect_base = 0,
		effect_value = 1,
		level_max = 10,
		tier = 1,
		tier_index = 0
	},
	UpgradesEnum.BEE_LIFETIME: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the lifetime of bees.",
		display_name = "Bee Lifetime",
		effect_base = 0,
		effect_value = 1,
		level_max = 10,
		tier = 1,
		tier_index = 1
	},
	UpgradesEnum.BEE_SPEED: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the speed of bees.",
		display_name = "Bee Speed",
		effect_base = 1,
		effect_value = 0.1,
		level_max = 10,
		tier = 1,
		tier_index = 2
	},
	UpgradesEnum.EGG_AUTO_SPAWN_RATE: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the auto spawn rate of eggs.",
		display_name = "Egg Auto Spawn Rate",
		effect_base = 1,
		effect_value = 0.1,
		level_max = 10,
		tier = 1,
		tier_index = 3
	},
	UpgradesEnum.FLOWER_SPAWN_RATE: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the spawn rate of flowers.",
		display_name = "Flower Spawn Rate",
		effect_base = 1,
		effect_value = 0.1,
		level_max = 10,
		tier = 1,
		tier_index = 4
	},
	UpgradesEnum.HONEY_FACTORY_MAX_POLLEN: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the max pollen of honey factory.",
		display_name = "Honey Factory Max Pollen",
		effect_base = 0,
		effect_value = 1,
		level_max = 10,
		tier = 1,
		tier_index = 5
	},
	UpgradesEnum.HONEY_FACTORY_PRODUCTION_RATE: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the production rate of honey factory.",
		display_name = "Honey Factory Production Rate",
		effect_value = 0.1,
		effect_base = 1,
		level_max = 10,
		tier = 1,
		tier_index = 6
	},
}

static func get_upgrade(upgrade_name: UpgradesEnum) -> Upgrade:
	return Upgrade.new(_UPGRADES[upgrade_name])

static func get_upgrade_cost(upgrade_name: UpgradesEnum, next_level: int) -> int:
	return _UPGRADES[upgrade_name].cost_base * _UPGRADES[upgrade_name].cost_multiplier ** next_level

static func get_upgrade_effect(upgrade_name: UpgradesEnum, level: int) -> float:
	return _UPGRADES[upgrade_name].effect_base + _UPGRADES[upgrade_name].effect_value * level

static func get_total_effect_of_upgrades(upgrade_names: Array[UpgradesEnum]) -> float:
	var total_effect: float = 1
	
	for upgrade_name in upgrade_names:
		total_effect *= get_upgrade_effect(upgrade_name, GameState.get_upgrade_level(upgrade_name))

	return total_effect
