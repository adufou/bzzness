extends MarginContainer
class_name BeeSpeciesPanelItem

var bee_species_enum: BeeSpecies.SpeciesEnum

func _ready() -> void:
	GameState.on_update_total_honey.connect(_update_purchasability)
	GameState.on_update_bee_species.connect(_update)
	
	_update()
	
func _update() -> void:
	%NameLabel.text = BeeSpecies.get_display_name(bee_species_enum)
	%DescriptionLabel.text = BeeSpecies.get_description(bee_species_enum)
	%MultiplierLabel.text = _prettify_multiplier()
	%BuyButton.text = _prettify_buy()
	
	_update_texture()
	_update_purchasability(GameState.total_honey)
	
func _prettify_buy() -> String:
	if bee_species_enum < GameState.bee_species:
		return "Previous Bee Species"

	if bee_species_enum == GameState.bee_species:
		return "Current Bee Species"
	
	return "Buy\n" + "%0.2f" % BeeSpecies.get_unlock_cost(bee_species_enum) + " Honey"

func _prettify_multiplier() -> String:
	return "x" + str(BeeSpecies.get_multiplier(bee_species_enum))
	
func _update_purchasability(total_honey: float) -> void:
	if bee_species_enum < GameState.bee_species or bee_species_enum == GameState.bee_species:
		%BuyButton.disabled = true
	elif total_honey < BeeSpecies.get_unlock_cost(bee_species_enum):
		%BuyButton.disabled = true
	else:
		%BuyButton.disabled = false

func _update_texture() -> void:
	var texture: Texture2D = load(BeeSpecies.get_texture_path(bee_species_enum))
	%TextureRect.texture = texture

func _on_buy_button_pressed() -> void:
	GameState.bee_species = bee_species_enum
