class_name Statistics

### |------- Bees -------| ###
static func compute_bees_pollen_capacity() -> void:
	GameState.bees_pollen_capacity = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.BEE_CARRY_CAPACITY]) * StatisticsConstants.BASE_BEE_CARRY_CAPACITY

static func compute_bees_lifetime_seconds() -> void:
	GameState.bees_lifetime_seconds = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.BEE_LIFETIME]) * StatisticsConstants.BASE_BEE_LIFETIME_SECONDS

static func compute_bees_speed() -> void:
	GameState.bees_speed = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.BEE_SPEED]) * StatisticsConstants.BASE_BEE_SPEED

### |------- Eggs -------| ###
static func compute_eggs_auto_spawn_rate_per_second() -> void:
	GameState.eggs_auto_spawn_rate_per_second = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.EGG_AUTO_SPAWN_RATE]) * StatisticsConstants.BASE_EGG_AUTO_SPAWN_RATE_PER_SECOND

### |------- Flowers -------| ###
static func compute_flowers_spawn_rate_per_second() -> void:
	GameState.flowers_spawn_rate_per_second = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.FLOWER_SPAWN_RATE]) * StatisticsConstants.BASE_FLOWER_SPAWN_RATE_PER_SECOND

### |------- Honey factory -------| ###
static func compute_honey_factory_max_pollen() -> void:
	GameState.honey_factory_max_pollen = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.HONEY_FACTORY_MAX_POLLEN]) * StatisticsConstants.BASE_HONEY_FACTORY_MAX_POLLEN

static func compute_honey_factory_production_rate_per_second() -> void:
	GameState.honey_factory_production_rate_per_second = Upgrades.get_total_effect_of_upgrades([Upgrades.UpgradesEnum.HONEY_FACTORY_PRODUCTION_RATE]) * StatisticsConstants.BASE_HONEY_FACTORY_PRODUCTION_RATE_PER_SECOND
