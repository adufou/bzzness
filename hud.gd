extends Control

func _ready() -> void:
	%BaseHudControl.on_open_bee_species_panel.connect(bee_species_panel_display)
	%BaseHudControl.on_open_prestige_panel.connect(prestige_panel_display)
	%BaseHudControl.on_open_statistics_panel.connect(statistics_panel_display)
	%BaseHudControl.on_open_upgrades_panel.connect(upgrades_panel_display)
	%BaseHudControl.on_open_options_panel.connect(options_panel_display)

	%BeeSpeciesPanel.on_close_species_panel.connect(bee_species_panel_hide)
	%PrestigePanel.on_close_prestige_panel.connect(prestige_panel_hide)
	%StatisticsPanel.on_close_statistics_panel.connect(statistics_panel_hide)
	%UpgradesPanelControl.on_close_upgrades_panel.connect(upgrades_panel_hide)
	%OptionsPanel.on_close_options_panel.connect(options_panel_hide)

func bee_species_panel_display() -> void:
	%BeeSpeciesPanel.show()

func bee_species_panel_hide() -> void:
	%BeeSpeciesPanel.hide()

func options_panel_display() -> void:
	%OptionsPanel.show()

func options_panel_hide() -> void:
	%OptionsPanel.hide()

func prestige_panel_display() -> void:
	%PrestigePanel.show()

func prestige_panel_hide() -> void:
	%PrestigePanel.hide()

func statistics_panel_display() -> void:
	%StatisticsPanel.show()

func statistics_panel_hide() -> void:
	%StatisticsPanel.hide()

func upgrades_panel_display() -> void:
	%UpgradesPanelControl.show()

func upgrades_panel_hide() -> void:
	%UpgradesPanelControl.hide()
