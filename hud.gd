extends Control

func _ready() -> void:
	%BaseHudControl.on_open_bee_species_panel.connect(bee_species_panel_display)
	%BaseHudControl.on_open_upgrades_panel.connect(upgrades_panel_display)
	
	%BeeSpeciesPanel.on_close_species_panel.connect(bee_species_panel_hide)
	%UpgradesPanelControl.on_close_upgrades_panel.connect(upgrades_panel_hide)

func bee_species_panel_display() -> void:
	%BeeSpeciesPanel.show()

func bee_species_panel_hide() -> void:
	%BeeSpeciesPanel.hide()

func upgrades_panel_display() -> void:
	%UpgradesPanelControl.show()

func upgrades_panel_hide() -> void:
	%UpgradesPanelControl.hide()
