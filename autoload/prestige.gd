extends Node

signal on_prestige_reset_requested
signal on_prestige_reset_completed

func get_royal_jelly_multiplier() -> float:
	return 1 + AttributesConstants.BASE_MULTIPLIER_BY_ROYAL_JELLY_HONEY * GameState.royal_jelly
	
func compute_prestige_reward() -> float:
	var current_prestige_total_honey: float = Statistics.get_statistic_value(Statistics.StatisticsEnum.CURRENT_PRESTIGE_TOTAL_HONEY)
	return max(0, sqrt(current_prestige_total_honey * log(current_prestige_total_honey)))

func execute_prestige_reset() -> void:
	on_prestige_reset_completed.emit()
	
	# 1. Reset statistics
	_reset_statistics()

	# 2. Reset game state
	_reset_game_state()

	# 3. Reset world
	_reset_world()

	on_prestige_reset_completed.emit()

	

func _reset_statistics() -> void:
	Statistics.initialize()

func _reset_game_state() -> void:
	GameState.initialize()
	
func _reset_world() -> void:
	pass
