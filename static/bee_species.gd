extends Node
class_name BeeSpecies

enum SpeciesEnum {
	MELLIFERA,
	CAUCASIA,
	CARNICA,
	LINGUSTICA
}

class Species:
	var unlock_cost: float
	var multiplier: float
	var display_name: String
	var description: String
	var texture_path: String
	
	func _init(species_dict: Dictionary):
		unlock_cost = species_dict.unlock_cost
		multiplier = species_dict.multiplier
		display_name = species_dict.display_name
		description = species_dict.description
		texture_path = species_dict.texture_path


const _SPECIES: Dictionary = {
	SpeciesEnum.MELLIFERA: {
		unlock_cost = 0,
		multiplier = 1,
		display_name = "Mellifera",
		description = "The Western honey bee, known for its versatility and widespread use in global beekeeping.",
		texture_path = "res://assets/bee_species/black.png"
	},
	SpeciesEnum.CAUCASIA: {
		unlock_cost = 1_000,
		multiplier = 2.5,
		display_name = "Caucasia",
		description = "A hardy bee from the Caucasus region, prized for its long tongue and gentle nature.",
		texture_path = "res://assets/bee_species/orange.png"
	},
	SpeciesEnum.CARNICA: {
		unlock_cost = 1_000_000,
		multiplier = 15,
		display_name = "Carnica",
		description = "Also called the Carniolan bee, favored for its calm behavior and excellent overwintering.",
		texture_path = "res://assets/bee_species/yellow.png"
	},
	SpeciesEnum.LINGUSTICA: {
		unlock_cost = 1_000_000_000,
		multiplier = 425,
		display_name = "Lingustica",
		description = "The Italian honey bee, popular for its productivity, cleanliness, and golden color.",
		texture_path = "res://assets/bee_species/purple.png"
	}
}

static func get_species(species: SpeciesEnum) -> Species:
	return Species.new(_SPECIES[species])
	
static func get_unlock_cost(species: SpeciesEnum) -> float:
	return _SPECIES[species].unlock_cost
	
static func get_multiplier(species: SpeciesEnum) -> float:
	return _SPECIES[species].multiplier
	
static func get_display_name(species: SpeciesEnum) -> String:
	return _SPECIES[species].display_name
	
static func get_description(species: SpeciesEnum) -> String:
	return _SPECIES[species].description

static func get_texture_path(species: SpeciesEnum) -> String:
	return _SPECIES[species].texture_path
