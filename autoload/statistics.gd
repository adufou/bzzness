extends Node

#################################### |---------------[ SIGNALS ]---------------| ####################################
##################### |------- TIME -------| #####################
### ----- Time ----- ###
signal on_update_total_time_played(time_played: int)
signal on_update_current_species_time_played(time_played: int)
signal on_update_current_prestige_time_played(time_played: int)

##################### |------- GOODS -------| #####################
### ----- Goods ----- ###
signal on_update_current_prestige_total_honey(honey: float)
signal on_update_total_pollen(pollen: float)
signal on_update_total_honey(honey: float)

#################################### |---------------[ ENUMS ]---------------| ####################################
enum StatisticsEnum {
	# |------- Time -------| #
	TOTAL_TIME_PLAYED,
	CURRENT_SPECIES_TIME_PLAYED,
	CURRENT_PRESTIGE_TIME_PLAYED,
	
	# |------- Goods -------| #
	CURRENT_PRESTIGE_TOTAL_HONEY,
	TOTAL_POLLEN,
	TOTAL_HONEY,
}

enum StatisticsType {
	TIME,
	GOODS,
}

class Statistic:
	var display_name: String
	var value: int
	var value_prefix: String
	var value_suffix: String
	var update_signal: Signal
	var statistics_type: StatisticsType

	func _init(statistics_dict: Dictionary):
		display_name = statistics_dict.display_name
		statistics_type = statistics_dict.statistics_type
		update_signal = statistics_dict.update_signal
		value = statistics_dict.value
		value_prefix = statistics_dict.value_prefix
		value_suffix = statistics_dict.value_suffix

var _STATISTICS: Dictionary = {
	StatisticsEnum.TOTAL_TIME_PLAYED: {
		display_name = "Total Time Played",
		statistics_type = StatisticsType.TIME,
		update_signal = on_update_total_time_played,
		value = 0,
		value_prefix = "",
		value_suffix = "s",
	},
	StatisticsEnum.CURRENT_SPECIES_TIME_PLAYED: {
		display_name = "Current Species Time Played",
		statistics_type = StatisticsType.TIME,
		update_signal = on_update_current_species_time_played,
		value = 0,
		value_prefix = "",
		value_suffix = "s",
	},
	StatisticsEnum.CURRENT_PRESTIGE_TIME_PLAYED: {
		display_name = "Current Prestige Time Played",
		statistics_type = StatisticsType.TIME,
		update_signal = on_update_current_prestige_time_played,
		value = 0,
		value_prefix = "",
		value_suffix = "s",
	},
	StatisticsEnum.CURRENT_PRESTIGE_TOTAL_HONEY: {
		display_name = "Current Prestige Total Honey",
		statistics_type = StatisticsType.GOODS,
		update_signal = on_update_current_prestige_total_honey,
		value = 0,
		value_prefix = "",
		value_suffix = "",
	},
	StatisticsEnum.TOTAL_POLLEN: {
		display_name = "Total Pollen",
		statistics_type = StatisticsType.GOODS,
		update_signal = on_update_total_pollen,
		value = 0,
		value_prefix = "",
		value_suffix = "",
	},
	StatisticsEnum.TOTAL_HONEY: {
		display_name = "Total Honey",
		statistics_type = StatisticsType.GOODS,
		update_signal = on_update_total_honey,
		value = 0,
		value_prefix = "",
		value_suffix = "",
	},
}

#################################### |---------------[ VALUES ]---------------| ####################################
### ----- Time ----- ###
var total_time_played: int:
	set(value):
		total_time_played = value
		on_update_total_time_played.emit(value)

var current_species_time_played: int:
	set(value):
		current_species_time_played = value
		on_update_current_species_time_played.emit(value)

var current_prestige_time_played: int:
	set(value):
		current_prestige_time_played = value
		on_update_current_prestige_time_played.emit(value)

### ----- Goods ----- ###
var current_prestige_total_honey: float:
	set(value):
		current_prestige_total_honey = value
		on_update_current_prestige_total_honey.emit(value)

var total_pollen: float:
	set(value):
		total_pollen = value
		on_update_total_pollen.emit(value)

var total_honey: float:
	set(value):
		total_honey = value
		on_update_total_honey.emit(value)

#################################### |---------------[ READY ]---------------| ####################################
func _ready() -> void:
	initialize()

#################################### |---------------[ METHODS ]---------------| ####################################
func initialize() -> void:
	_initialize_current_species_statistics()
	_initialize_current_prestige_statistics()
	_initialize_total_statistics()

func _initialize_current_species_statistics() -> void:
	current_species_time_played = 0 
func _initialize_current_prestige_statistics() -> void:
	current_prestige_time_played = 0
	current_prestige_total_honey = 0
	
func _initialize_total_statistics() -> void:
	total_time_played = 0	
	total_pollen = 0
	total_honey = 0

func get_statistic_display_name(statistic_enum: Statistics.StatisticsEnum) -> String:
	return _STATISTICS[statistic_enum].display_name
	
func get_statistic_display_value(statistic_enum: Statistics.StatisticsEnum) -> String:
	var value_str: String = "%0.2f" % get_statistic_value(statistic_enum)
	return _STATISTICS[statistic_enum].value_prefix + value_str + _STATISTICS[statistic_enum].value_suffix

func get_statistic_update_signal(statistic_enum: Statistics.StatisticsEnum) -> Signal:
	return _STATISTICS[statistic_enum].update_signal

func get_statistic_type(statistic_enum: Statistics.StatisticsEnum) -> Statistics.StatisticsType:
	return _STATISTICS[statistic_enum].statistics_type

func get_statistic_value(statistic_enum: Statistics.StatisticsEnum) -> float:
	match statistic_enum:
		StatisticsEnum.TOTAL_TIME_PLAYED: return total_time_played
		StatisticsEnum.CURRENT_SPECIES_TIME_PLAYED: return current_species_time_played
		StatisticsEnum.CURRENT_PRESTIGE_TIME_PLAYED: return current_prestige_time_played
		StatisticsEnum.CURRENT_PRESTIGE_TOTAL_HONEY: return current_prestige_total_honey
		StatisticsEnum.TOTAL_POLLEN: return total_pollen
		StatisticsEnum.TOTAL_HONEY: return total_honey
	
	return -1
