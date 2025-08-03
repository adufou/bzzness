extends Control

signal on_close_options_panel

func _on_close_button_pressed() -> void:
	on_close_options_panel.emit()

func _on_save_button_pressed() -> void:
	SaveSystem.force_save()

func _on_new_game_button_pressed() -> void:
	SaveSystem.delete_save()
	Prestige.execute_prestige_reset()
