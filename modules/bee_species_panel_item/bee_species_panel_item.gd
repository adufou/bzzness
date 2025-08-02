extends MarginContainer
class_name BeeSpeciesPanelItem

var bee_species_enum: BeeSpecies.SpeciesEnum

func _ready() -> void:
	%NameLabel.text = BeeSpecies.get_display_name(bee_species_enum)
	%DescriptionLabel.text = BeeSpecies.get_description(bee_species_enum)
	%MultiplierLabel.text = _prettify_multiplier()
	%BuyButton.text = _prettify_buy()
	
func _prettify_buy() -> String:
	return "Buy\n" + "%0.2f" % BeeSpecies.get_unlock_cost(bee_species_enum) + " Honey"

func _prettify_multiplier() -> String:
	return "x" + str(BeeSpecies.get_multiplier(bee_species_enum))
	
