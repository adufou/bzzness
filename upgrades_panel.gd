extends Control

signal on_close_upgrades_panel


func _on_close_upgrades_panel_button_pressed() -> void:
	on_close_upgrades_panel.emit()
