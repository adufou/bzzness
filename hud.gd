extends Control

func _ready() -> void:
	%BaseHudControl.on_open_upgrades_panel.connect(upgrades_panel_display)
	%UpgradesPanelControl.on_close_upgrades_panel.connect(upgrades_panel_hide)

func upgrades_panel_display() -> void:
	%UpgradesPanelControl.show()

func upgrades_panel_hide() -> void:
	%UpgradesPanelControl.hide()
