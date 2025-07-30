extends Node

#################################### |---------------[ SIGNALS ]---------------| ####################################
##################### |------- UPGRADES -------| #####################
### ----- Tier 1 ----- ###
signal on_update_tier_1_upgrade_level_bees_carry_capacity()
signal on_update_tier_1_upgrade_level_bees_lifetime()
signal on_update_tier_1_upgrade_level_bees_speed()
signal on_update_tier_1_upgrade_level_eggs_auto_spawn_rate()
signal on_update_tier_1_upgrade_level_flowers_spawn_rate()
signal on_update_tier_1_upgrade_level_honey_factory_pollen_to_honey_rate()
signal on_update_tier_1_upgrade_level_honey_factory_production_quantity()
signal on_update_tier_1_upgrade_level_honey_factory_production_rate()

##################### |------- STATISTICS -------| #####################
### ----- Bees ----- ###
signal on_update_bees_lifetime_seconds(value: float)
signal on_update_bees_pollen_capacity(value: float)
signal on_update_bees_speed(value: float)

### ----- Eggs ----- ###
signal on_update_eggs_auto_spawn_rate_per_second(value: float)

### ----- Flowers ----- ###
signal on_update_flowers_spawn_rate_per_second(value: float)

### ----- Honey factory ----- ###
signal on_update_honey_factory_pollen_to_honey_rate(value: float)
signal on_update_honey_factory_production_quantity(value: float)
signal on_update_honey_factory_production_rate_per_second(value: float)

##################### |------- GOODS -------| #####################
### ----- Currencies ----- ###
signal on_update_total_pollen(value: float)
signal on_update_total_honey(value: float)

### ----- Honey factory ----- ###
signal on_update_honey_factory_total_pollen(value: float)

##################### |------- PRODUCTION -------| #####################
### ----- Honey factory ----- ###
signal on_update_honey_factory_production_progress_as_quantity(value: float)

#################################### |---------------[ VALUES ]---------------| ####################################
##################### |------- UPGRADES -------| #####################
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

var tier_1_upgrade_level_honey_factory_pollen_to_honey_rate: int:
	set(value):
		tier_1_upgrade_level_honey_factory_pollen_to_honey_rate = value
		on_update_tier_1_upgrade_level_honey_factory_pollen_to_honey_rate.emit()
		Statistics.compute_honey_factory_pollen_to_honey_rate()

var tier_1_upgrade_level_honey_factory_production_quantity: int:
	set(value):
		tier_1_upgrade_level_honey_factory_production_quantity = value
		on_update_tier_1_upgrade_level_honey_factory_production_quantity.emit()
		Statistics.compute_honey_factory_production_quantity()

var tier_1_upgrade_level_honey_factory_production_rate: int:
	set(value):
		tier_1_upgrade_level_honey_factory_production_rate = value
		on_update_tier_1_upgrade_level_honey_factory_production_rate.emit()
		Statistics.compute_honey_factory_production_rate_per_second()

#####################	 |------- STATISTICS -------| #####################
### ----- Bees ----- ###
var bees_pollen_capacity: float:
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

### ----- Honey factory ----- ###
var honey_factory_pollen_to_honey_rate: float:
	set(value):
		honey_factory_pollen_to_honey_rate = value
		on_update_honey_factory_pollen_to_honey_rate.emit(value)

var honey_factory_production_quantity: float:
	set(value):
		honey_factory_production_quantity = value
		on_update_honey_factory_production_quantity.emit(value)

var honey_factory_production_rate_per_second: float:
	set(value):
		honey_factory_production_rate_per_second = value
		on_update_honey_factory_production_rate_per_second.emit(value)

##################### |------- GOODS -------| #####################
### ----- Currencies ----- ###
var total_pollen: float:
	set(value):
		total_pollen = value
		on_update_total_pollen.emit(value)

var total_honey: float:
	set(value):
		total_honey = value
		print_debug({"total_honey": total_honey})
		on_update_total_honey.emit(value)

### ----- Honey factory ----- ###
var honey_factory_total_pollen: float:
	set(value):
		honey_factory_total_pollen = value
		on_update_honey_factory_total_pollen.emit(value)

##################### |------- PRODUCTION -------| #####################
### ----- Honey factory ----- ###
var honey_factory_production_progress_as_quantity: float:
	set(value):
		honey_factory_production_progress_as_quantity = value
		on_update_honey_factory_production_progress_as_quantity.emit(value)
	

#################################### |---------------[ READY ]---------------| ####################################
func _ready() -> void:
	##################### |------- UPGRADES -------| #####################
	### ----- Tier 1 ----- ###
	tier_1_upgrade_level_bees_carry_capacity = 0
	tier_1_upgrade_level_bees_lifetime = 0
	tier_1_upgrade_level_bees_speed = 0
	tier_1_upgrade_level_eggs_auto_spawn_rate = 0
	tier_1_upgrade_level_flowers_spawn_rate = 0
	tier_1_upgrade_level_honey_factory_pollen_to_honey_rate = 0
	tier_1_upgrade_level_honey_factory_production_quantity = 0
	tier_1_upgrade_level_honey_factory_production_rate = 0
	
	total_honey = 42069

#################################### |---------------[ METHODS ]---------------| ####################################
func get_upgrade_level(upgrade_name: Upgrades.UpgradesEnum) -> int:
	match upgrade_name:
		Upgrades.UpgradesEnum.BEE_CARRY_CAPACITY: return tier_1_upgrade_level_bees_carry_capacity
		Upgrades.UpgradesEnum.BEE_LIFETIME: return tier_1_upgrade_level_bees_lifetime
		Upgrades.UpgradesEnum.BEE_SPEED: return tier_1_upgrade_level_bees_speed
		Upgrades.UpgradesEnum.EGG_AUTO_SPAWN_RATE: return tier_1_upgrade_level_eggs_auto_spawn_rate
		Upgrades.UpgradesEnum.FLOWER_SPAWN_RATE: return tier_1_upgrade_level_flowers_spawn_rate
		Upgrades.UpgradesEnum.HONEY_FACTORY_POLLEN_TO_HONEY_RATE: return tier_1_upgrade_level_honey_factory_pollen_to_honey_rate
		Upgrades.UpgradesEnum.HONEY_FACTORY_PRODUCTION_QUANTITY: return tier_1_upgrade_level_honey_factory_production_quantity
		Upgrades.UpgradesEnum.HONEY_FACTORY_PRODUCTION_RATE: return tier_1_upgrade_level_honey_factory_production_rate
		
	return -1

func set_upgrade_level(upgrade_name: Upgrades.UpgradesEnum, level: int) -> void:
	match upgrade_name:
		Upgrades.UpgradesEnum.BEE_CARRY_CAPACITY: tier_1_upgrade_level_bees_carry_capacity = level
		Upgrades.UpgradesEnum.BEE_LIFETIME: tier_1_upgrade_level_bees_lifetime = level
		Upgrades.UpgradesEnum.BEE_SPEED: tier_1_upgrade_level_bees_speed = level
		Upgrades.UpgradesEnum.EGG_AUTO_SPAWN_RATE: tier_1_upgrade_level_eggs_auto_spawn_rate = level
		Upgrades.UpgradesEnum.FLOWER_SPAWN_RATE: tier_1_upgrade_level_flowers_spawn_rate = level
		Upgrades.UpgradesEnum.HONEY_FACTORY_POLLEN_TO_HONEY_RATE: tier_1_upgrade_level_honey_factory_pollen_to_honey_rate = level
		Upgrades.UpgradesEnum.HONEY_FACTORY_PRODUCTION_QUANTITY: tier_1_upgrade_level_honey_factory_production_quantity = level
		Upgrades.UpgradesEnum.HONEY_FACTORY_PRODUCTION_RATE: tier_1_upgrade_level_honey_factory_production_rate = level

func get_upgrade_signal(upgrade_name: Upgrades.UpgradesEnum) -> Signal:
	match upgrade_name:
		Upgrades.UpgradesEnum.BEE_CARRY_CAPACITY: return on_update_tier_1_upgrade_level_bees_carry_capacity
		Upgrades.UpgradesEnum.BEE_LIFETIME: return on_update_tier_1_upgrade_level_bees_lifetime
		Upgrades.UpgradesEnum.BEE_SPEED: return on_update_tier_1_upgrade_level_bees_speed
		Upgrades.UpgradesEnum.EGG_AUTO_SPAWN_RATE: return on_update_tier_1_upgrade_level_eggs_auto_spawn_rate
		Upgrades.UpgradesEnum.FLOWER_SPAWN_RATE: return on_update_tier_1_upgrade_level_flowers_spawn_rate
		Upgrades.UpgradesEnum.HONEY_FACTORY_POLLEN_TO_HONEY_RATE: return on_update_tier_1_upgrade_level_honey_factory_pollen_to_honey_rate
		Upgrades.UpgradesEnum.HONEY_FACTORY_PRODUCTION_QUANTITY: return on_update_tier_1_upgrade_level_honey_factory_production_quantity
		Upgrades.UpgradesEnum.HONEY_FACTORY_PRODUCTION_RATE: return on_update_tier_1_upgrade_level_honey_factory_production_rate
	
	return Signal()
