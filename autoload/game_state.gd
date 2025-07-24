extends Node

func _ready() -> void:
	##### |------- UPGRADES -------| #####
	### ----- Tier 1 ----- ###
	tier_1_upgrade_level_bee_carry_capacity = 0
	tier_1_upgrade_level_bee_lifetime = 0
	tier_1_upgrade_level_bee_speed = 0

################## |---------------[ SIGNALS ]---------------| ##################
##### |------- UPGRADES -------| #####
### ----- Tier 1 ----- ###
signal on_update_tier_1_upgrade_level_bee_carry_capacity(value: int)
signal on_update_tier_1_upgrade_level_bee_lifetime(value: int)
signal on_update_tier_1_upgrade_level_bee_speed(value: int)

##### |------- STATISTICS -------| #####
### ----- Bees ----- ###
signal on_update_bees_lifetime_seconds(value: float)
signal on_update_bees_pollen_capacity(value: int)
signal on_update_bees_speed(value: float)

##### |------- GOODS -------| #####
### ----- Currencies ----- ###
signal on_update_total_pollen(value: int)

################## |---------------[ VALUES ]---------------| ##################
##### |------- UPGRADES -------| #####
### ----- Tier 1 ----- ###
var tier_1_upgrade_level_bee_carry_capacity: int:
	set(value):
		tier_1_upgrade_level_bee_carry_capacity = value
		on_update_tier_1_upgrade_level_bee_carry_capacity.emit(value)
		Statistics.compute_bees_pollen_capacity()

var tier_1_upgrade_level_bee_lifetime: int:
	set(value):
		tier_1_upgrade_level_bee_lifetime = value
		on_update_tier_1_upgrade_level_bee_lifetime.emit(value)
		Statistics.compute_bees_lifetime_seconds()

var tier_1_upgrade_level_bee_speed: int:
	set(value):
		tier_1_upgrade_level_bee_speed = value
		on_update_tier_1_upgrade_level_bee_speed.emit(value)
		Statistics.compute_bees_speed()

##### |------- STATISTICS -------| #####
### ----- Bees ----- ###
var bees_pollen_capacity: int = 1:
	set(value):
		bees_pollen_capacity = value
		on_update_bees_pollen_capacity.emit(value)

var bees_lifetime_seconds: float = 10:
	set(value):
		bees_lifetime_seconds = value
		on_update_bees_lifetime_seconds.emit(value)

var bees_speed: float = 1.0:
	set(value):
		bees_speed = value
		on_update_bees_speed.emit(value)

##### |------- GOODS -------| #####
### ----- Currencies ----- ###
var total_pollen: int = 0:
	set(value):
		total_pollen = value
		on_update_total_pollen.emit(value)
