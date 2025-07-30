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
	terrain_collision_shape_3d = %TerrainInherited/CollisionShape3D
	
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
	var processable_honey: float = GameState.honey_factory_production_rate_per_second * delta
	var process_honey_cost: float = GameState.honey_factory_pollen_to_honey_rate * processable_honey
	
	if (GameState.honey_factory_total_pollen < process_honey_cost):
		return
	
	GameState.honey_factory_total_pollen -= process_honey_cost
	
	GameState.honey_factory_production_progress_as_quantity += processable_honey
	var nb_of_completions: int = GameState.honey_factory_production_progress_as_quantity / GameState.honey_factory_production_quantity

	if (nb_of_completions == 0):
		return
		
	var produced_honey = nb_of_completions * GameState.honey_factory_production_quantity
	GameState.honey_factory_production_progress_as_quantity -= produced_honey

	GameState.total_honey += produced_honey

func create_egg() -> void:
	var egg: Egg = egg_scene.instantiate()
	egg.position = %GridMap.random_egg_position()
	_adjust_object_position_to_terrain(egg)
	
	egg.request_spawn_larva.connect(hatch_egg)
	
	add_child(egg)
	
func hatch_egg(egg_position: Vector3) -> void:	
	var larva: Larva = larva_scene.instantiate()
	larva.position = egg_position
	_adjust_object_position_to_terrain(larva)
	
	larva.hatchery_position = %GridMap.random_nest_position()
	
	larva.request_spawn_bee.connect(spawn_bee)
	
	add_sibling(larva)

func _assign_flower_to_gatherer_bee(gatherer_component: GathererComponent) -> void:
	if flowers.is_empty():
		return
		
	var flower: Flower = flowers.values().pick_random()
	gatherer_component.aimed_flower = flower

func _assign_hive_cells_position_to_bee(bee: Bee) -> void:
	bee.hive_cells_position = %GridMap.random_hive_cells_position()

func _assign_honey_factory_position_to_worker_bee(worker_component: WorkerComponent) -> void:
	worker_component.honey_factory_position = %GridMap.random_honey_factory_position()

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
	bee.on_deposit_pollen_to_honey_factory.connect(_handle_pollen_deposit_to_honey_factory)
	
	add_sibling(bee)

func _remove_flower(flower: Flower) -> void:
	flowers.erase(flower.get_instance_id())

func spawn_flower() -> void:
	var flower: Flower = flower_scene.instantiate()
	var flower_id: int = flower.get_instance_id()

	flower.position = %GridMap.random_flower_position()
	_adjust_object_position_to_terrain(flower)

	flower.on_queue_free.connect(_remove_flower)
	
	flowers[flower_id] = flower
	add_sibling(flower)

func _adjust_object_position_to_terrain(object: Node3D) -> void:
	var position = object.position
	position.y = get_terrain_height_at(position)
	object.position = position

func get_terrain_height_at(position: Vector3) -> float:
	var from = Vector3(position.x, 100, position.z)
	var to = Vector3(position.x, -100, position.z)
	
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var collision = space.intersect_ray(query)
	
	if collision and "collider" in collision and "position" in collision:
		var collider = collision["collider"]
		# You can check by name
		if "Terrain" in collider.name:
			return collision["position"].y
		
		# Or alternatively by group
		# if collider.is_in_group("terrain"):
		#    return collision["position"].y
	
	return position.y
