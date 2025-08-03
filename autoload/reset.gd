extends Node

enum ResetType {
	RESET_TYPE_SPECIES,
	RESET_TYPE_PRESTIGE,
	RESET_TYPE_NEW_GAME,
}

signal on_world_restart_requested
signal on_world_restart_completed

func new_game_reset() -> void:
	# 1. Reset statistics
	_reset_statistics(ResetType.RESET_TYPE_NEW_GAME)

	# 2. Reset game state
	_reset_game_state(ResetType.RESET_TYPE_NEW_GAME)

	# 3. Reset world
	_reset_world()

func prestige_reset() -> void:
	# 1. Reset statistics
	_reset_statistics(ResetType.RESET_TYPE_PRESTIGE)

	# 2. Reset game state
	_reset_game_state(ResetType.RESET_TYPE_PRESTIGE)

	# 3. Reset world
	_reset_world()
	
func species_reset() -> void:
	# 1. Reset statistics
	_reset_statistics(ResetType.RESET_TYPE_SPECIES)

	# 2. Reset game state
	_reset_game_state(ResetType.RESET_TYPE_SPECIES)

	# 3. Reset world
	_reset_world()


func _reset_statistics(reset_type: ResetType) -> void:
	Statistics.initialize(reset_type)

func _reset_game_state(reset_type: ResetType) -> void:
	GameState.initialize(reset_type)
	
func _reset_world() -> void:
	on_world_restart_requested.emit()
	await on_world_restart_completed
