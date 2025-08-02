extends Control

@export var species_item_scene: PackedScene

var _species_items: Dictionary[BeeSpecies.SpeciesEnum, BeeSpeciesPanelItem] = {}
var current_species_item: BeeSpeciesPanelItem = null

signal on_close_species_panel

func _ready() -> void:
	instantiate_species_items()

func instantiate_species_items() -> void:
	for species_name: String in BeeSpecies.SpeciesEnum:
		var species_item: BeeSpeciesPanelItem = species_item_scene.instantiate()
		species_item.bee_species_enum = BeeSpecies.SpeciesEnum[species_name]
		_species_items[BeeSpecies.SpeciesEnum[species_name]] = species_item
		
	select_bee_species(GameState.bee_species)

func select_bee_species(bee_species: BeeSpecies.SpeciesEnum) -> void:
	if current_species_item:
		current_species_item.queue_free()
	
	var selected_item: BeeSpeciesPanelItem = _species_items[bee_species]
	%SpeciesGalleryMarginContainer.add_child(selected_item)

func _on_close_button_pressed() -> void:
	on_close_species_panel.emit()

func _on_previous_button_pressed() -> void:
	pass # Replace with function body.


func _on_next_button_pressed() -> void:
	pass # Replace with function body.
