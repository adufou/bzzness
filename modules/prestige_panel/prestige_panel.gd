extends Control

signal on_close_prestige_panel

var prestige_reward: float

func _ready() -> void:
	GameState.on_update_royal_jelly.connect(_update_current_royal_jelly_labels)
	Statistics.on_update_current_prestige_total_honey.connect(_update_next_prestige_reward)
	
	_update_current_royal_jelly_labels(GameState.royal_jelly)
	_update_next_prestige_reward()
	
func _update_current_royal_jelly_labels(royal_jelly: int) -> void:
	%CurrentRoyalJellyLabel.text = str(GameState.royal_jelly) + " Royal Jelly"
	
	var percent_increase: float = (Prestige.get_royal_jelly_multiplier() - 1) * 100
	var percent_increase_str: String = "%0.2f" % percent_increase
	%CurrentRoyalJellyDescriptionLabel.text = "Your Royal Jelly provide you with a +" + percent_increase_str + "% increase in honey produced"

	var individual_increase: float = AttributesConstants.BASE_MULTIPLIER_BY_ROYAL_JELLY_HONEY * 100
	var individual_increase_str: String = "%0.2f" % individual_increase
	%RoyalJellyDescriptionLabel.text = "Each Royal Jelly grants +" + individual_increase_str + "%"

func _update_next_prestige_reward(_new_current_prestige_total_honey: float = 0.0) -> void:
	prestige_reward = Prestige.compute_prestige_reward()
	
	var whole_part = int(prestige_reward)
	_update_next_prestige_label(whole_part)

	var progress: float = (prestige_reward - whole_part) * 100
	_update_next_prestige_progress_bar(progress)

func _update_next_prestige_label(next_prestige_royal_jelly: int) -> void:
	%NextPrestigeRoyalJellyLabel.text = str(next_prestige_royal_jelly) + " Royal Jelly"

func _update_next_prestige_progress_bar(progress: float) -> void:
	%ProgressBar.value = progress

func _on_close_button_pressed() -> void:
	on_close_prestige_panel.emit()
	
func _on_prestige_button_pressed() -> void:
	GameState.royal_jelly += prestige_reward
