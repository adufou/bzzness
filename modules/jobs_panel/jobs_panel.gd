extends Control

signal on_close_jobs_panel

func _ready() -> void:
	%GathererHSlider.value = GameState.gatherer_weight
	%WorkerHSlider.value = GameState.worker_weight

func _on_gatherer_h_slider_value_changed(value: float) -> void:
	GameState.gatherer_weight = value

func _on_worker_h_slider_value_changed(value: float) -> void:
	GameState.worker_weight = value

func _on_close_jobs_panel_button_pressed() -> void:
	on_close_jobs_panel.emit()
