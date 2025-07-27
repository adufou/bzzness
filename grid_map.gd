extends GridMap

enum ITEMS {
	GRASS,
	HATCHERY,
	NEST,
	HIVE_CELLS,
	HONEY_FACTORY
}

func _random_item_position(item: int) -> Vector3:
	var item_cells: Array[Vector3i] = get_used_cells_by_item(item)
	var random_item_cell_position: Vector3i = item_cells.pick_random()
	
	var position_x: float = random_item_cell_position.x + randf()
	var position_z: float = random_item_cell_position.z + randf()
	var position: Vector3 = Vector3(position_x, 0, position_z)
	
	return position

func random_egg_position() -> Vector3:
	return _random_item_position(ITEMS.HATCHERY)

func random_nest_position() -> Vector3:
	return _random_item_position(ITEMS.NEST)

func random_flower_position() -> Vector3:
	return _random_item_position(ITEMS.GRASS)

func random_hive_cells_position() -> Vector3:
	return _random_item_position(ITEMS.HIVE_CELLS)

func random_honey_factory_position() -> Vector3:
	return _random_item_position(ITEMS.HONEY_FACTORY)
	
