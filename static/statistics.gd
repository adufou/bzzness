class_name Statistics


static func compute_bees_pollen_capacity() -> void:
	GameState.bees_pollen_capacity = (1 + GameState.tier_1_upgrade_level_bee_carry_capacity * 0.1) * StatisticsConstants.BASE_BEE_CARRY_CAPACITY

static func compute_bees_lifetime_seconds() -> void:
	GameState.bees_lifetime_seconds = (1 + GameState.tier_1_upgrade_level_bee_lifetime * 0.1) * StatisticsConstants.BASE_BEE_LIFETIME_SECONDS

static func compute_bees_speed() -> void:
	GameState.bees_speed = (1 + GameState.tier_1_upgrade_level_bee_speed * 0.1) * StatisticsConstants.BASE_BEE_SPEED
