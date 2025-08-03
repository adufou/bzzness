class_name Prestige

static func get_royal_jelly_multiplier() -> float:
	return 1 + AttributesConstants.BASE_MULTIPLIER_BY_ROYAL_JELLY_HONEY * GameState.royal_jelly
	
static func compute_prestige_reward() -> float:
	var current_prestige_total_honey: float = Statistics.get_statistic_value(Statistics.StatisticsEnum.CURRENT_PRESTIGE_TOTAL_HONEY)
	return max(0, sqrt(current_prestige_total_honey * log(current_prestige_total_honey)))
