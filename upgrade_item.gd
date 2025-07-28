extends HBoxContainer

var upgrade: Upgrades.UpgradesEnum = Upgrades.UpgradesEnum.BEE_CARRY_CAPACITY

var is_button_pressed: bool = false

func _ready() -> void:
	GameState.get_upgrade_signal(upgrade).connect(update)
	update()

func _process(delta: float) -> void:
	if is_button_pressed:
		GameState.set_upgrade_level(upgrade, GameState.get_upgrade_level(upgrade) + 1)

func update():
	var level: int = GameState.get_upgrade_level(upgrade)
	%LevelLabel.text = "Lv. " + str(level)
	%EffectLabel.text = "+" + str(Upgrades.get_upgrade_effect(upgrade, level)) + "%"

func _on_buy_button_button_down() -> void:
	is_button_pressed = true

func _on_buy_button_button_up() -> void:
	is_button_pressed = false
