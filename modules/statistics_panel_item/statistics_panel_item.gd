extends HBoxContainer
class_name StatisticsPanelItem

var statistic_enum: Statistics.StatisticsEnum

func _ready() -> void:
	_update_value_label()
	_update_name_label()
	
	Statistics.get_statistic_update_signal(statistic_enum).connect(_update_value_label)
	
func _update_value_label(_value: float = 0) -> void:
	%ValueLabel.text = Statistics.get_statistic_display_value(statistic_enum)

func _update_name_label() -> void:
	%NameLabel.text = Statistics.get_statistic_display_name(statistic_enum)
