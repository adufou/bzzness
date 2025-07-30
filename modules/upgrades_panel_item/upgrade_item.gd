extends HBoxContainer
class_name UpgradeItem

var upgrade_enum: Upgrades.UpgradesEnum

var _level: int
var _upgrade: Upgrades.Upgrade

var is_button_pressed: bool = false

func _ready() -> void:
	GameState.get_upgrade_signal(upgrade_enum).connect(update)
	_upgrade = Upgrades.get_upgrade(upgrade_enum)
	
	%ProgressBar.max_value = _upgrade.level_max
	update()

func _process(delta: float) -> void:
	if is_button_pressed:
		GameState.set_upgrade_level(upgrade_enum, _level + 1)

func update():
	_level = GameState.get_upgrade_level(upgrade_enum)
	%LevelLabel.text = _prettify_level()
	%ProgressBar.value = _level
	%EffectLabel.text = _prettify_effect()
	%NameLabel.text = _upgrade.display_name
	%DescriptionLabel.text = _upgrade.description

func _prettify_level() -> String:
	var level_max: int = _upgrade.level_max
	
	return "Lv. " + str(_level) + " / " + str(level_max)

func _prettify_effect() -> String:
	var effect: float = Upgrades.get_upgrade_effect(upgrade_enum, _level)
	var effect_difference_in_percent: int = int((effect - 1) * 100)
	
	return "+" + str(effect_difference_in_percent) + "%"

func _on_buy_button_button_down() -> void:
	is_button_pressed = true

func _on_buy_button_button_up() -> void:
	is_button_pressed = false
