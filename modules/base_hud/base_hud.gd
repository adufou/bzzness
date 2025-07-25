extends Control

signal on_open_upgrades_panel

func _ready() -> void:
	GameState.on_update_total_pollen.connect(update_pollen_label)

func _on_create_egg_button_pressed() -> void:
	HudInterface.on_create_egg.emit()

func update_pollen_label(pollen: int) -> void:
	%PollenLabel.text = str(pollen) + " Pollen"

func _on_open_upgrades_button_pressed() -> void:
	on_open_upgrades_panel.emit()
