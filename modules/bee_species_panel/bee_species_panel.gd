extends Control

@export var species_item_scene: PackedScene

var _bee_species_items: Dictionary[BeeSpecies.SpeciesEnum, BeeSpeciesPanelItem]
var current_bee_species: BeeSpecies.SpeciesEnum

signal on_close_species_panel

func _ready() -> void:
	_instantiate_bee_species_items()
	select_bee_species(GameState.bee_species)
	
func _instantiate_bee_species_items() -> void:
	for bee_species_name: String in BeeSpecies.SpeciesEnum:
		var species_item: BeeSpeciesPanelItem = species_item_scene.instantiate()
		species_item.bee_species_enum = BeeSpecies.SpeciesEnum[bee_species_name]
		species_item.hide()
		
		_bee_species_items[BeeSpecies.SpeciesEnum[bee_species_name]] = species_item
		%BeeSpeciesGalleryMarginContainer.add_child(species_item)
	
func select_bee_species(bee_species: BeeSpecies.SpeciesEnum) -> void:	
	_bee_species_items[current_bee_species].hide()
		
	current_bee_species = bee_species	
	_bee_species_items[current_bee_species].show()
	
	_update_navigation_buttons_visibility()
	
func _update_navigation_buttons_visibility() -> void:	
	if (current_bee_species == 0):
		%PreviousButton.hide()
	else:
		%PreviousButton.show()
	
	if (current_bee_species == BeeSpecies.SpeciesEnum.size() - 1):
		%NextButton.hide()
	else:
		%NextButton.show()
		
func _on_close_button_pressed() -> void:
	on_close_species_panel.emit()

func _on_previous_button_pressed() -> void:
	select_bee_species(current_bee_species - 1)

func _on_next_button_pressed() -> void:
	select_bee_species(current_bee_species + 1)
