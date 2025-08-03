extends Node

signal on_game_saved
signal on_game_loaded

const SAVE_FILE_PATH = "user://bzzness_save.json"
const SAVE_VERSION = "1.0.0" # For future compatibility

# How often to autosave (in seconds)
@export var autosave_interval: float = 60.0
var time_since_last_save: float = 0.0
@export var autosave_enabled: bool = true

# Configuration for which autoloads to save 
# This is now using NodePath which makes it more type-safe
@export var autoloads_to_save: Array[Node] = [GameState, Statistics]
@export var property_exclusions: Dictionary = {
	"Statistics": ["_STATISTICS"], # Dictionary with static data
	"GameState": [], # Save everything
}

# Property types that should be saved
const SAVEABLE_PROPERTY_TYPES = [
	TYPE_BOOL,
	TYPE_INT,
	TYPE_FLOAT,
	TYPE_STRING,
	TYPE_VECTOR2,
	TYPE_VECTOR3,
	TYPE_DICTIONARY,
	TYPE_ARRAY,
]

func _ready() -> void:
	# Load the game on startup
	load_game()
	
func _process(delta: float) -> void:
	if autosave_enabled:
		time_since_last_save += delta
		if time_since_last_save >= autosave_interval:
			save_game()
			time_since_last_save = 0.0

# Main save function
func save_game() -> void:
	var save_data = {
		"version": SAVE_VERSION,
		"timestamp": Time.get_unix_time_from_system(),
	}
	
	# Automatically gather data from all configured autoloads
	for autoload in autoloads_to_save:
		if autoload:
			# Get the autoload name from the path
			var autoload_name = autoload.get_name()
			save_data[autoload_name.to_lower()] = get_object_saveable_properties(
				autoload, 
				property_exclusions.get(autoload_name, [])
			)
	
	# Save special case data that needs custom handling
	save_data = add_special_case_data(save_data)
	
	# Save to file
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data, "\t"))
		file.close()
		print("Game saved successfully")
		on_game_saved.emit()
	else:
		push_error("Failed to save game: " + str(FileAccess.get_open_error()))

# Special case handling for data that can't be automatically saved
func add_special_case_data(save_data: Dictionary) -> Dictionary:
	# Example: Store upgrade levels in a more structured way
	if "gamestate" in save_data:
		var upgrade_levels = {}
		for upgrade in Upgrades.UpgradesEnum.values():
			var upgrade_name = Upgrades.UpgradesEnum.keys()[upgrade]
			upgrade_levels[upgrade_name] = GameState.get_upgrade_level(upgrade)
		
		save_data["gamestate"]["upgrade_levels"] = upgrade_levels
	
	return save_data

# Main load function
func load_game() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		print("No save file found, starting new game")
		return
		
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if not file:
		push_error("Failed to open save file: " + str(FileAccess.get_open_error()))
		return
		
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		push_error("Failed to parse save file JSON: " + json.get_error_message())
		return
		
	var save_data = json.get_data()
	
	# Check version compatibility (for future use)
	if save_data.has("version"):
		# Here you could handle migration between save versions if needed
		pass
	
	# Apply saved data to each autoload
	for autoload in autoloads_to_save:
		if autoload:
			var autoload_name = autoload.get_name()
			var key = autoload_name.to_lower()
			if save_data.has(key):
				apply_data_to_object(autoload, save_data[key])
	
	# Handle special case data
	apply_special_case_data(save_data)
	
	print("Game loaded successfully")
	on_game_loaded.emit()

# Special case handling for data that can't be automatically loaded
func apply_special_case_data(save_data: Dictionary) -> void:
	# Example: Apply upgrade levels from structured data
	if save_data.has("gamestate") and save_data["gamestate"].has("upgrade_levels"):
		var upgrade_levels = save_data["gamestate"]["upgrade_levels"]
		for upgrade_name in upgrade_levels:
			if upgrade_name in Upgrades.UpgradesEnum:
				var upgrade_enum = Upgrades.UpgradesEnum[upgrade_name]
				GameState.set_upgrade_level(upgrade_enum, upgrade_levels[upgrade_name])

# Get all saveable properties from an object
func get_object_saveable_properties(object: Object, exclusions: Array = []) -> Dictionary:
	var data = {}
	
	for prop in object.get_property_list():
		var name = prop.name
		
		# Skip properties in the exclusion list
		if name in exclusions:
			continue
			
		# Skip built-in properties, script properties, and constants
		if name.begins_with("_") or name == "script" or prop.usage & PROPERTY_USAGE_CATEGORY or prop.usage & PROPERTY_USAGE_CLASS_IS_ENUM:
			continue
			
		# Only save properties with saveable types - this is the only type check we need
		if not prop.type in SAVEABLE_PROPERTY_TYPES:
			continue
		
		# Get the property value
		var value = object.get(name)
		
		# Save the property if it's a valid type
		data[name] = value
		
	return data

# Apply data to an object's properties
func apply_data_to_object(object: Object, data: Dictionary) -> void:
	for prop_name in data.keys():
		# Skip properties that don't exist in the target object
		if not prop_name in object:
			continue
			
		# Set the property value
		object.set(prop_name, data[prop_name])

# Manually trigger a save
func force_save() -> void:
	save_game()
	
# Delete the save file (for testing or when starting a new game)
func delete_save() -> bool:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var result = DirAccess.remove_absolute(SAVE_FILE_PATH)
		if result == OK:
			print("Save file deleted successfully")
			return true
		else:
			push_error("Failed to delete save file: " + str(result))
	else:
		print("No save file found to delete")
	return false

# Check if a save file exists
func has_save_file() -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH)

# Get metadata about the save file without loading the full game
func get_save_metadata() -> Dictionary:
	if not has_save_file():
		return {}
		
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if not file:
		return {}
		
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		return {}
		
	var data = json.get_data()
	
	# Return only metadata, not the full save
	return {
		"version": data.get("version", "unknown"),
		"timestamp": data.get("timestamp", 0),
		"datetime": Time.get_datetime_string_from_unix_time(data.get("timestamp", 0)),
	}
