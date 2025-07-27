extends Node

################## |---------------[ SIGNALS ]---------------| ##################
##### |------- UPGRADES -------| #####
### ----- Tier 1 ----- ###
signal on_update_tier_1_upgrade_level_bees_carry_capacity()
signal on_update_tier_1_upgrade_level_bees_lifetime()
signal on_update_tier_1_upgrade_level_bees_speed()
signal on_update_tier_1_upgrade_level_eggs_auto_spawn_rate()
signal on_update_tier_1_upgrade_level_flowers_spawn_rate()

##### |------- STATISTICS -------| #####
### ----- Bees ----- ###
signal on_update_bees_lifetime_seconds(value: float)
signal on_update_bees_pollen_capacity(value: int)
signal on_update_bees_speed(value: float)

### ----- Eggs ----- ###
signal on_update_eggs_auto_spawn_rate_per_second(value: float)

### ----- Flowers ----- ###
signal on_update_flowers_spawn_rate_per_second(value: float)

##### |------- GOODS -------| #####
### ----- Currencies ----- ###
signal on_update_total_pollen(value: int)

################## |---------------[ VALUES ]---------------| ##################
##### |------- UPGRADES -------| #####
### ----- Tier 1 ----- ###
var tier_1_upgrade_level_bees_carry_capacity: int:
	set(value):
		tier_1_upgrade_level_bees_carry_capacity = value
		on_update_tier_1_upgrade_level_bees_carry_capacity.emit()
		Statistics.compute_bees_pollen_capacity()

var tier_1_upgrade_level_bees_lifetime: int:
	set(value):
		tier_1_upgrade_level_bees_lifetime = value
		on_update_tier_1_upgrade_level_bees_lifetime.emit()
		Statistics.compute_bees_lifetime_seconds()

var tier_1_upgrade_level_bees_speed: int:
	set(value):
		tier_1_upgrade_level_bees_speed = value
		on_update_tier_1_upgrade_level_bees_speed.emit()
		Statistics.compute_bees_speed()

var tier_1_upgrade_level_eggs_auto_spawn_rate: int:
	set(value):
		tier_1_upgrade_level_eggs_auto_spawn_rate = value
		on_update_tier_1_upgrade_level_eggs_auto_spawn_rate.emit()
		Statistics.compute_eggs_auto_spawn_rate_per_second()

var tier_1_upgrade_level_flowers_spawn_rate: int:
	set(value):
		tier_1_upgrade_level_flowers_spawn_rate = value
		on_update_tier_1_upgrade_level_flowers_spawn_rate.emit()
		Statistics.compute_flowers_spawn_rate_per_second()

##### |------- STATISTICS -------| #####
### ----- Bees ----- ###
var bees_pollen_capacity: int:
	set(value):
		bees_pollen_capacity = value
		on_update_bees_pollen_capacity.emit(value)

var bees_lifetime_seconds: float:
	set(value):
		bees_lifetime_seconds = value
		on_update_bees_lifetime_seconds.emit(value)

var bees_speed: float:
	set(value):
		bees_speed = value
		on_update_bees_speed.emit(value)

### ----- Eggs ----- ###
var eggs_auto_spawn_rate_per_second: float:
	set(value):
		eggs_auto_spawn_rate_per_second = value
		on_update_eggs_auto_spawn_rate_per_second.emit(value)

### ----- Flowers ----- ###
var flowers_spawn_rate_per_second: float:
	set(value):
		flowers_spawn_rate_per_second = value
		on_update_flowers_spawn_rate_per_second.emit(value)

##### |------- GOODS -------| #####
### ----- Currencies ----- ###
var total_pollen: int:
	set(value):
		total_pollen = value
		on_update_total_pollen.emit(value)


################## |---------------[ READY ]---------------| ##################
func _ready() -> void:
	##### |------- UPGRADES -------| #####
	### ----- Tier 1 ----- ###
	tier_1_upgrade_level_bees_carry_capacity = 0
	tier_1_upgrade_level_bees_lifetime = 0
	tier_1_upgrade_level_bees_speed = 0
	tier_1_upgrade_level_eggs_auto_spawn_rate = 0
	tier_1_upgrade_level_flowers_spawn_rate = 0
