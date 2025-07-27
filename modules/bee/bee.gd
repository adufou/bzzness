extends Node3D
class_name Bee

signal on_request_flower(bee: Bee)
signal on_request_hive_cells_position(bee: Bee)
signal on_deposit_pollen(pollen: int)
signal on_request_honey_factory_position(bee: Bee)

var lifetime_seconds: float = GameState.bees_lifetime_seconds
var pollen_capacity: int = GameState.bees_pollen_capacity
var speed: float = GameState.bees_speed

var aimed_flower: Flower
var hive_cells_position: Vector3
var honey_factory_position: Vector3
var pollen_carried: int = 0
var remaining_lifetime: float = lifetime_seconds

# Components
@onready var death_effect_component = $DeathEffectComponent
@onready var movement_component = $MovementComponent
@onready var roll_component = $RollComponent

func _ready() -> void:
	on_request_flower.emit(self)
	on_request_hive_cells_position.emit(self)
	on_request_honey_factory_position.emit(self)

func _process(delta: float) -> void:
	remaining_lifetime -= delta
	if (remaining_lifetime <= 0):
		death_effect_component.trigger(self)
		queue_free()
	
	%LifetimeLabel3D.text = "%.2fs" % remaining_lifetime
	%CarryLabel3D.text = str(pollen_carried) + "/" + str(pollen_capacity)
	
	if is_full():
		if is_at_hive_cells_position():
			deposit_pollen()
		else:
			move_to_hive_cells_position(delta)
	else:
		if not check_flower():
			return

		if is_at_flower():
			harvest_pollen()
		else:
			move_to_flower(delta)

func check_flower() -> bool:
	if aimed_flower == null:
		on_request_flower.emit(self)
		return false
	
	return true

func deposit_pollen() -> void:
	on_deposit_pollen.emit(pollen_carried)
	pollen_carried = 0

func harvest_pollen() -> void:
	var available_pollen_carry: int = pollen_capacity - pollen_carried
	var pollen_harvested: int = aimed_flower.harvest_pollen(available_pollen_carry)
	pollen_carried += pollen_harvested

func is_full() -> bool:
	return pollen_carried >= pollen_capacity

func is_at_flower() -> bool:
	var distance_to_flower: Vector3 = aimed_flower.position - global_transform.origin
	
	return distance_to_flower.length() < 0.5

func move_to_flower(delta: float) -> void:
	# Handle movement and rotation in one call
	var y_rotation = 0.0
	y_rotation = movement_component.move_to(self, aimed_flower.position, delta)
	
	# Apply roll based on rotation if component exists
	roll_component.apply_roll(self, y_rotation, delta)

func is_at_hive_cells_position() -> bool:
	var distance_to_hive_cells_position: Vector3 = hive_cells_position - global_transform.origin
	
	return distance_to_hive_cells_position.length() < 0.5

func move_to_hive_cells_position(delta: float) -> void:
	# Handle movement and rotation in one call
	var y_rotation = 0.0
	y_rotation = movement_component.move_to(self, hive_cells_position, delta)
	
	# Apply roll based on rotation if component exists
	roll_component.apply_roll(self, y_rotation, delta)
