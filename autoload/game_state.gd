extends Node

################## |---------------[ SIGNALS ]---------------| ##################
##### |------- UPGRADES -------| #####
### ----- Tier 1 ----- ###
signal on_update_tier_1_upgrade_level_bee_speed(value: int)
signal on_update_tier_1_upgrade_level_bee_lifetime(value: int)
signal on_update_tier_1_upgrade_level_bee_carry_capacity(value: int)

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
var tier_1_upgrade_level_bee_speed: int = 1:
	set(value):
		tier_1_upgrade_level_bee_speed = value
		on_update_tier_1_upgrade_level_bee_speed.emit(value)

var tier_1_upgrade_level_bee_lifetime: int = 1:
	set(value):
		tier_1_upgrade_level_bee_lifetime = value
		on_update_tier_1_upgrade_level_bee_lifetime.emit(value)

var tier_1_upgrade_level_bee_carry_capacity: int = 1:
	set(value):
		tier_1_upgrade_level_bee_carry_capacity = value
		on_update_tier_1_upgrade_level_bee_carry_capacity.emit(value)

##### |------- STATISTICS -------| #####
### ----- Bees ----- ###
var bees_lifetime_seconds: float = 10:
	set(value):
		bees_lifetime_seconds = value
		on_update_bees_lifetime_seconds.emit(value)

var bees_pollen_capacity: int = 1:
	set(value):
		bees_pollen_capacity = value
		on_update_bees_pollen_capacity.emit(value)

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
