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

    func _init(species_dict: Dictionary):
        unlock_cost = species_dict.unlock_cost
        multiplier = species_dict.multiplier
        display_name = species_dict.display_name
        description = species_dict.description

const _SPECIES: Dictionary = {
    SpeciesEnum.MELLIFERA: {
        unlock_cost = 0,
        multiplier = 1,
        display_name = "Mellifera",
        description = "The Western honey bee, known for its versatility and widespread use in global beekeeping."
    },
    SpeciesEnum.CAUCASIA: {
        unlock_cost = 1_000,
        multiplier = 2.5,
        display_name = "Caucasia",
        description = "A hardy bee from the Caucasus region, prized for its long tongue and gentle nature."
    },
    SpeciesEnum.CARNICA: {
        unlock_cost = 1_000_000,
        multiplier = 15,
        display_name = "Carnica",
        description = "Also called the Carniolan bee, favored for its calm behavior and excellent overwintering."
    },
    SpeciesEnum.LINGUSTICA: {
        unlock_cost = 1_000_000_000,
        multiplier = 425,
        display_name = "Lingustica",
        description = "The Italian honey bee, popular for its productivity, cleanliness, and golden color."
    }
}