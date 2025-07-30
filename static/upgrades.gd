extends Node
class_name Upgrades

enum UpgradesEnum {
	BEE_CARRY_CAPACITY,
	BEE_LIFETIME,
	BEE_SPEED,
	EGG_AUTO_SPAWN_RATE,
	FLOWER_SPAWN_RATE,
	HONEY_FACTORY_PRODUCTION_RATE,
	HONEY_FACTORY_PRODUCTION_QUANTITY,
	HONEY_FACTORY_POLLEN_TO_HONEY_RATE
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
		effect_base = 1,
		effect_value = 0.1,
		level_max = 25,
		tier = 1,
		tier_index = 0
	},
	UpgradesEnum.BEE_LIFETIME: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the lifetime of bees.",
		display_name = "Bee Lifetime",
		effect_base = 1,
		effect_value = 0.1,
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
		effect_value = 0.01,
		level_max = 50,
		tier = 1,
		tier_index = 2
	},
	UpgradesEnum.EGG_AUTO_SPAWN_RATE: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the auto spawn rate of eggs.",
		display_name = "Egg Auto Spawn Rate",
		effect_base = 1,
		effect_value = 0.05,
		level_max = 50,
		tier = 1,
		tier_index = 3
	},
	UpgradesEnum.FLOWER_SPAWN_RATE: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the spawn rate of flowers.",
		display_name = "Flower Spawn Rate",
		effect_base = 1,
		effect_value = 0.05,
		level_max = 20,
		tier = 1,
		tier_index = 4
	},
	UpgradesEnum.HONEY_FACTORY_PRODUCTION_RATE: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the production rate of honey factory.",
		display_name = "Honey Factory Production Rate",
		effect_base = 1,
		effect_value = 0.1,
		level_max = 30,
		tier = 1,
		tier_index = 6
	},
	UpgradesEnum.HONEY_FACTORY_PRODUCTION_QUANTITY: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the production quantity of honey factory.",
		display_name = "Honey Factory Production Quantity",
		effect_base = 1,
		effect_value = 0.01,
		level_max = 100,
		tier = 1,
		tier_index = 7
	},
	UpgradesEnum.HONEY_FACTORY_POLLEN_TO_HONEY_RATE: {
		cost_base = 1,
		cost_multiplier = 1.1,
		description = "Increases the pollen to honey rate of honey factory.",
		display_name = "Honey Factory Pollen To Honey Rate",
		effect_base = 1,
		effect_value = 0.01,
		level_max = 10,
		tier = 1,
		tier_index = 8
	}
}

static func get_upgrade(upgrade: UpgradesEnum) -> Upgrade:
	return Upgrade.new(_UPGRADES[upgrade])

static func get_upgrade_cost(upgrade: UpgradesEnum, next_level: int) -> int:
	return _UPGRADES[upgrade].cost_base * _UPGRADES[upgrade].cost_multiplier ** next_level

static func get_upgrade_effect(upgrade: UpgradesEnum, level: int) -> float:
	return _UPGRADES[upgrade].effect_base + _UPGRADES[upgrade].effect_value * level

static func get_total_effect_of_upgrades(upgrades: Array[UpgradesEnum]) -> float:
	var total_effect: float = 1
	
	for upgrade in upgrades:
		total_effect *= get_upgrade_effect(upgrade, GameState.get_upgrade_level(upgrade))

	return total_effect
