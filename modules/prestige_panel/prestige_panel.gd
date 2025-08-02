extends Control

signal on_close_prestige_panel

var prestige_reward: int = 1_000 #TODO: Formula

func _ready() -> void:
	GameState.on_update_royal_jelly.connect(_update_current_royal_jelly_labels)
	
	_update_current_royal_jelly_labels(GameState.royal_jelly)
	_update_next_prestige_label(prestige_reward)
	
func _update_current_royal_jelly_labels(royal_jelly: int) -> void:
	%CurrentRoyalJellyLabel.text = str(GameState.royal_jelly) + " Royal Jelly"
	
	var percent_increase: float = (Prestige.get_royal_jelly_multiplier() - 1) * 100
	var percent_increase_str: String = "%0.2f" % percent_increase
	%CurrentRoyalJellyDescriptionLabel.text = "Your Royal Jelly provide you with a +" + percent_increase_str + "% increase in honey produced"

func _update_next_prestige_label(next_prestige_royal_jelly: int) -> void:
	%NextPrestigeRoyalJellyLabel.text = str(next_prestige_royal_jelly) + " Royal Jelly"

func _on_close_button_pressed() -> void:
	on_close_prestige_panel.emit()
	
func _on_prestige_button_pressed() -> void:
	GameState.royal_jelly += prestige_reward
