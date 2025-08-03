extends MarginContainer
class_name StatisticsPanelType

var statistics_panel_item_scene: PackedScene
var statistics_type: Statistics.StatisticsType

func _ready() -> void:
	instantiate_statistics_items()
	
func instantiate_statistics_items() -> void:
	for statistic_name: String in Statistics.StatisticsEnum:
		if Statistics.get_statistic_type(Statistics.StatisticsEnum[statistic_name]) != statistics_type:
			continue
		
		var statistics_panel_item: StatisticsPanelItem = statistics_panel_item_scene.instantiate()
		statistics_panel_item.statistic_enum = Statistics.StatisticsEnum[statistic_name]
		%StatisticsVBoxContainer.add_child(statistics_panel_item)
