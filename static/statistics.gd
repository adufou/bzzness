class_name Statistics

### |------- Bees -------| ###
static func compute_bees_pollen_capacity() -> void:
	GameState.bees_pollen_capacity = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.TIER_1_BEE_CARRY_CAPACITY]) * StatisticsConstants.BASE_TIER_1_BEE_CARRY_CAPACITY

static func compute_bees_lifetime_seconds() -> void:
	GameState.bees_lifetime_seconds = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.TIER_1_BEE_LIFETIME]) * StatisticsConstants.BASE_TIER_1_BEE_LIFETIME_SECONDS

static func compute_bees_speed() -> void:
	GameState.bees_speed = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.TIER_1_BEE_SPEED]) * StatisticsConstants.BASE_TIER_1_BEE_SPEED

### |------- Eggs -------| ###
static func compute_eggs_auto_spawn_rate_per_second() -> void:
	GameState.eggs_auto_spawn_rate_per_second = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.TIER_1_EGG_AUTO_SPAWN_RATE]) * StatisticsConstants.BASE_TIER_1_EGG_AUTO_SPAWN_RATE_PER_SECOND

### |------- Flowers -------| ###
static func compute_flowers_spawn_rate_per_second() -> void:
	GameState.flowers_spawn_rate_per_second = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.TIER_1_FLOWER_SPAWN_RATE]) * StatisticsConstants.BASE_TIER_1_FLOWER_SPAWN_RATE_PER_SECOND

### |------- Honey factory -------| ###
static func compute_honey_factory_production_rate_per_second() -> void:
	GameState.honey_factory_production_rate_per_second = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.TIER_1_HONEY_FACTORY_PRODUCTION_RATE]) * StatisticsConstants.BASE_TIER_1_HONEY_FACTORY_PRODUCTION_RATE_PER_SECOND

static func compute_honey_factory_honey_by_pollen_rate() -> void:
	GameState.honey_factory_honey_by_pollen_rate = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.TIER_1_HONEY_FACTORY_HONEY_BY_POLLEN_RATE]) * StatisticsConstants.BASE_TIER_1_HONEY_FACTORY_HONEY_BY_POLLEN_RATE
