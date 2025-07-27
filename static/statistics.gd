class_name Statistics

### |------- Bees -------| ###
static func compute_bees_pollen_capacity() -> void:
	GameState.bees_pollen_capacity = (1 + GameState.tier_1_upgrade_level_bees_carry_capacity * 0.1) * StatisticsConstants.BASE_BEE_CARRY_CAPACITY

static func compute_bees_lifetime_seconds() -> void:
	GameState.bees_lifetime_seconds = (1 + GameState.tier_1_upgrade_level_bees_lifetime * 0.1) * StatisticsConstants.BASE_BEE_LIFETIME_SECONDS

static func compute_bees_speed() -> void:
	GameState.bees_speed = (1 + GameState.tier_1_upgrade_level_bees_speed * 0.1) * StatisticsConstants.BASE_BEE_SPEED

### |------- Eggs -------| ###
static func compute_eggs_auto_spawn_rate_per_second() -> void:
	GameState.eggs_auto_spawn_rate_per_second = (1 + GameState.tier_1_upgrade_level_eggs_auto_spawn_rate * 0.1) * StatisticsConstants.BASE_EGG_AUTO_SPAWN_RATE_PER_SECOND
