extends Node

################## |---------------[ SIGNALS ]---------------| ##################
##### |------- UPGRADES -------| #####
### ----- Bees ----- ###
signal on_update_bees_lifetime_seconds(value: float)
signal on_update_bees_pollen_capacity(value: int)
signal on_update_bees_speed(value: float)

##### |------- GOODS -------| #####
### ----- Currencies ----- ###
signal on_update_total_pollen(value: int)

################## |---------------[ VALUES ]---------------| ##################
##### |------- UPGRADES -------| #####
### ----- Bees ----- ###
var bees_lifetime_seconds: float = 10:
	set(value):
		bees_lifetime_seconds = value
		on_update_bees_lifetime_seconds.emit(value)

var bees_pollen_capacity: int = 3:
	set(value):
		bees_pollen_capacity = value
		on_update_bees_pollen_capacity.emit(value)

var bees_speed: float = 5.0:
	set(value):
		bees_speed = value
		on_update_bees_speed.emit(value)

##### |------- GOODS -------| #####
### ----- Currencies ----- ###
var total_pollen: int = 0:
	set(value):
		total_pollen = value
		on_update_total_pollen.emit(value)
