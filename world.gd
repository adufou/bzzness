extends Node3D

@export var egg_scene: PackedScene
@export var larva_scene: PackedScene
@export var bee_scene: PackedScene
@export var flower_scene: PackedScene

const FLOWER_SPAWN_CHANCE: float = 0.5
const FLOWER_SPAWN_TRY_RATE_SECONDS: float = 1

var next_flower_spawn_try_remaining_time = FLOWER_SPAWN_TRY_RATE_SECONDS

var flowers: Dictionary[int, Flower] = {}

func _ready() -> void:
	HudInterface.on_create_egg.connect(create_egg)

func _process(delta: float) -> void:
	next_flower_spawn_try_remaining_time -= delta
	
	if (next_flower_spawn_try_remaining_time <= 0):
		var try_roll: float = randf()
		if (try_roll > FLOWER_SPAWN_CHANCE):
			return
			
		spawn_flower()
		next_flower_spawn_try_remaining_time += FLOWER_SPAWN_TRY_RATE_SECONDS

func create_egg() -> void:
	var egg: Egg = egg_scene.instantiate()
	egg.position = %GridMap.random_egg_position()
	
	egg.request_spawn_larva.connect(hatch_egg)
	
	add_child(egg)
	
func hatch_egg(egg_position: Vector3) -> void:	
	var larva: Larva = larva_scene.instantiate()
	larva.position = egg_position
	larva.hatchery_spot = %GridMap.random_nest_position()
	
	larva.request_spawn_bee.connect(spawn_bee)
	
	add_sibling(larva)

func _assign_flower_to_bee(bee: Bee) -> void:
	var flower: Flower = flowers.values().pick_random()
	bee.aimed_flower = flower

func _assign_hive_cells_spot_to_bee(bee: Bee) -> void:
	bee.hive_cells_spot = %GridMap.random_hive_cells_spot()

func _handle_pollen_deposit(pollen: int) -> void:
	GameState.total_pollen += pollen

func spawn_bee(bee_position: Vector3) -> void:
	var bee: Bee = bee_scene.instantiate()
	bee.position = bee_position

	bee.on_request_flower.connect(_assign_flower_to_bee)
	bee.on_request_hive_cells_spot.connect(_assign_hive_cells_spot_to_bee)
	bee.on_deposit_pollen.connect(_handle_pollen_deposit)
	
	add_sibling(bee)

func _remove_flower(flower: Flower) -> void:
	flowers.erase(flower.get_instance_id())

func spawn_flower() -> void:
	var flower: Flower = flower_scene.instantiate()
	var flower_id: int = flower.get_instance_id()

	flower.position = %GridMap.random_flower_position()

	flower.on_queue_free.connect(_remove_flower)
	
	flowers[flower_id] = flower
	add_sibling(flower)
