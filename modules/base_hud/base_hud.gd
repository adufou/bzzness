extends Control

signal on_open_upgrades_panel
signal on_open_bee_species_panel

func _ready() -> void:
	%DevCheckButton.button_pressed = GameState.is_dev_mode
	
	GameState.on_update_is_dev_mode.connect(update_dev_mode_button)
	GameState.on_update_total_honey.connect(update_honey_label)
	GameState.on_update_honey_factory_production_progress_as_quantity.connect(_update_honey_factory_production_progress_bar)
	GameState.on_update_honey_factory_production_quantity.connect(_update_honey_factory_production_progress_bar)
	GameState.on_update_honey_factory_total_pollen.connect(update_honey_factory_pollen_label)
	GameState.on_update_total_pollen.connect(update_pollen_label)

func _on_create_egg_button_pressed() -> void:
	HudInterface.on_create_egg.emit()

func _on_open_upgrades_button_pressed() -> void:
	on_open_upgrades_panel.emit()

func _on_open_species_button_pressed() -> void:
	on_open_bee_species_panel.emit()

func _on_dev_check_button_toggled(toggled_on: bool) -> void:
	GameState.is_dev_mode = toggled_on

func update_dev_mode_button(value: bool) -> void:
	%DevCheckButton.button_pressed = value

func _update_honey_factory_production_progress_bar(_value: float) -> void:
	var progress_bar: ProgressBar = %HoneyFactoryProductionProgressBar
	progress_bar.value = (GameState.honey_factory_production_progress_as_quantity / GameState.honey_factory_production_quantity) * 100

func update_honey_label(honey: float) -> void:
	%HoneyLabel.text = "%0.2f" % honey + " Honey"

func update_honey_factory_pollen_label(pollen: float) -> void:
	%HoneyFactoryPollenLabel.text = "%0.2f" % pollen + " Honey Factory Pollen"

func update_pollen_label(pollen: float) -> void:
	%PollenLabel.text = "%0.2f" % pollen + " Pollen"
