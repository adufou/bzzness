extends Control

signal on_create_egg

func _on_create_egg_button_pressed() -> void:
	on_create_egg.emit()
