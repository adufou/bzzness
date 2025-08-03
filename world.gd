extends Node3D

@export var egg_scene: PackedScene
@export var larva_scene: PackedScene
@export var bee_scene: PackedScene
@export var flower_scene: PackedScene

var terrain_collision_shape_3d: CollisionShape3D

var eggs_auto_spawnable: float = 0
var flowers_auto_spawnable: float = 0

var flowers: Dictionary[int, Flower] = {}

func _ready() -> void:
	HudInterface.on_create_egg.connect(create_egg)

func _process(delta: float) -> void:
	_auto_spawn_eggs(delta)
	_auto_spawn_flowers(delta)
	_process_honey_factory(delta)
	terrain_collision_shape_3d = %TerrainInherited/Grid/StaticBody3D/CollisionShape3D
	
func _auto_spawn_eggs(delta: float) -> void:
	eggs_auto_spawnable += delta * GameState.eggs_auto_spawn_rate_per_second
	
	while eggs_auto_spawnable > 0:
		create_egg()
		eggs_auto_spawnable -= 1

func _auto_spawn_flowers(delta: float) -> void:
	flowers_auto_spawnable += delta * GameState.flowers_spawn_rate_per_second
	
	while flowers_auto_spawnable > 0:
		spawn_flower()
		flowers_auto_spawnable -= 1
		
func _process_honey_factory(delta: float) -> void:
	var max_production_of_honey: float = delta * GameState.honey_factory_production_rate_per_second
	var max_cost_in_pollen: float = max_production_of_honey / GameState.honey_factory_honey_by_pollen_rate

	var processable_ratio: float = min(1.0, GameState.honey_factory_total_pollen / max_cost_in_pollen)

	var cost_in_pollen: float = max_cost_in_pollen * processable_ratio
	var production_of_honey: float = max_production_of_honey * processable_ratio

	var total_production_of_honey: float = production_of_honey * BeeSpecies.get_multiplier(GameState.bee_species) * Prestige.get_royal_jelly_multiplier()
	
	GameState.honey_factory_total_pollen -= cost_in_pollen
	GameState.total_honey += total_production_of_honey
	
	Statistics.total_honey += total_production_of_honey
	Statistics.current_prestige_total_honey += total_production_of_honey

	GameState.honey_factory_gains_per_second = total_production_of_honey / delta

func _get_egg_position() -> Vector3:
	var hatchery_position: Vector3 = %Hatchery.global_transform.origin
	
	# Return a position in a circle around the hatchery of radius 10, excluding and 3 radius circle inside
	var angle = randf() * 2 * PI
	var radius = randf() * 7 + 3
	return Vector3(hatchery_position.x + radius * cos(angle), 0, hatchery_position.z + radius * sin(angle))

func create_egg() -> void:
	var egg: Egg = egg_scene.instantiate()
	egg.position = _get_egg_position()
	_adjust_object_position_to_terrain(egg)
	
	egg.request_spawn_larva.connect(hatch_egg)
	
	add_child(egg)
	
func hatch_egg(egg_position: Vector3) -> void:	
	var larva: Larva = larva_scene.instantiate()
	larva.position = egg_position
	_adjust_object_position_to_terrain(larva)
	
	larva.hatchery_position = %Nest.global_transform.origin
	
	larva.request_spawn_bee.connect(spawn_bee)
	
	add_sibling(larva)

func _assign_flower_to_gatherer_bee(gatherer_component: GathererComponent) -> void:
	if flowers.is_empty():
		return
	
	# Get bee position
	var bee: Bee = gatherer_component.get_parent().get_parent()
	var bee_position = bee.global_transform.origin
	
	# Define the predicate function to identify valid flowers
	var is_valid_flower = func(node):
		return node is Flower
	
	# Use the generic utility function to find the closest flower
	var closest_flower = WorldUtils.find_closest_entity_in_radius(
		bee_position,     # Origin point
		self,            # Entity for world reference
		2,              # Collision mask (2 for flowers)
		is_valid_flower, # Predicate function
		10.0,           # Initial radius
		500.0,          # Maximum radius
		2.0            # Radius multiplier
	)
	
	# Assign the closest flower if found
	if closest_flower != null:
		gatherer_component.aimed_flower = closest_flower

func _assign_hive_cells_position_to_bee(bee: Bee) -> void:
	bee.hive_cells_position = %HiveCells.global_transform.origin

func _assign_honey_factory_position_to_worker_bee(worker_component: WorkerComponent) -> void:
	worker_component.honey_factory_position = %HoneyFactory.global_transform.origin

func _handle_pollen_deposit_to_hive_cells(pollen: float) -> void:
	GameState.total_pollen += pollen

func _handle_pollen_deposit_to_honey_factory(pollen: float) -> void:
	GameState.honey_factory_total_pollen += pollen

func spawn_bee(bee_position: Vector3) -> void:
	var bee: Bee = bee_scene.instantiate()
	bee.position = bee_position
	_adjust_object_position_to_terrain(bee)

	bee.on_request_flower.connect(_assign_flower_to_gatherer_bee)
	bee.on_request_hive_cells_position.connect(_assign_hive_cells_position_to_bee)
	bee.on_request_honey_factory_position.connect(_assign_honey_factory_position_to_worker_bee)
	bee.on_deposit_pollen_to_hive_cells.connect(_handle_pollen_deposit_to_hive_cells)
	bee.on_deposit_honey_by_pollen_factory.connect(_handle_pollen_deposit_to_honey_factory)
	
	add_sibling(bee)

func _remove_flower(flower: Flower) -> void:
	flowers.erase(flower.get_instance_id())

func _get_flower_position() -> Vector3:
	# Position inside random range, will use or update later. 
	var position_x: float = randf_range(-10, 10)
	var position_z: float = randf_range(-10, 10)
	return Vector3(position_x, 0, position_z)

func spawn_flower() -> void:
	var flower: Flower = flower_scene.instantiate()
	var flower_id: int = flower.get_instance_id()

	flower.position = _get_flower_position()
	_adjust_object_position_to_terrain(flower)

	flower.on_queue_free.connect(_remove_flower)
	
	flowers[flower_id] = flower
	add_sibling(flower)

func _adjust_object_position_to_terrain(object: Node3D) -> void:
	var position = object.position
	position.y = WorldUtils.get_terrain_height_at(position, self)
	object.position = position
