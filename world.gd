extends Node3D

@export var egg_scene: PackedScene
@export var larva_scene: PackedScene
@export var bee_scene: PackedScene

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

func spawn_bee(bee_position: Vector3) -> void:
	var bee: Bee = bee_scene.instantiate()
	bee.position = bee_position
	
	add_sibling(bee)
