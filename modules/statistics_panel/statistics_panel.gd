extends Control

@export var statistics_panel_types_scene: PackedScene
@export var statistics_panel_item_scene: PackedScene

signal on_close_statistics_panel
	
var _statistics_panel_types: Dictionary[int, StatisticsPanelType] = {}

func _ready() -> void:
	for statistic_type_name: String in Statistics.StatisticsType:
		var statistics_type_enum: Statistics.StatisticsType = Statistics.StatisticsType[statistic_type_name]
		
		var statistics_panel_type: StatisticsPanelType = statistics_panel_types_scene.instantiate()
		statistics_panel_type.statistics_type = statistics_type_enum
		statistics_panel_type.statistics_panel_item_scene = statistics_panel_item_scene
		
		%StatisticsTypesVBoxContainer.add_child(statistics_panel_type)
		
		_statistics_panel_types[statistics_type_enum] = statistics_panel_type
	
func _on_close_button_pressed() -> void:
	on_close_statistics_panel.emit()
