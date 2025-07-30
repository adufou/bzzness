extends HBoxContainer
class_name UpgradeItem

var upgrade_enum: Upgrades.UpgradesEnum

var _level: int
var _upgrade: Upgrades.Upgrade

var _is_button_pressed: bool = false

func _ready() -> void:
	GameState.get_upgrade_signal(upgrade_enum).connect(update)
	GameState.on_update_total_honey.connect(_update_purchasability)
	_upgrade = Upgrades.get_upgrade(upgrade_enum)
	
	%ProgressBar.max_value = _upgrade.level_max
	update()

func _process(delta: float) -> void:
	if _is_button_pressed:
		GameState.set_upgrade_level(upgrade_enum, _level + 1)

func update():
	_level = GameState.get_upgrade_level(upgrade_enum)
	%BuyButton.text = _prettify_buy()
	%DescriptionLabel.text = _upgrade.description
	%EffectLabel.text = _prettify_effect()
	%LevelLabel.text = _prettify_level()
	%NameLabel.text = _upgrade.display_name
	%ProgressBar.value = _level
	
	_update_purchasability(GameState.total_honey)

func _update_purchasability(total_honey: float) -> void:
	if _level == _upgrade.level_max || total_honey < Upgrades.get_upgrade_cost(upgrade_enum, _level + 1):
		_is_button_pressed = false
		%BuyButton.disabled = true
	else:
		%BuyButton.disabled = false

func _prettify_buy() -> String:
	if _level == _upgrade.level_max:
		return "MAX" 

	var result: String = "Buy\n"
	
	var cost: float = Upgrades.get_upgrade_cost(upgrade_enum, _level + 1)
	
	result += "%0.2f" % cost + " Honey"
	
	return result

func _prettify_effect() -> String:
	var effect: float = Upgrades.get_upgrade_effect(upgrade_enum, _level)
	var effect_difference_in_percent: int = int((effect - 1) * 100)
	
	return "+" + str(effect_difference_in_percent) + "%"

func _prettify_level() -> String:
	var level_max: int = _upgrade.level_max
	
	return "Lv. " + str(_level) + " / " + str(level_max)

func _on_buy_button_button_down() -> void:
	_is_button_pressed = true

func _on_buy_button_button_up() -> void:
	_is_button_pressed = false
