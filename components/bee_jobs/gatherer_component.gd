extends Component
class_name GathererComponent

var aimed_flower: Flower

func _deposit_pollen_to_hive_cells(bee: Bee) -> void:
	bee.on_deposit_pollen_to_hive_cells.emit(bee.pollen_carried)
	bee.pollen_carried = 0

func _harvest_pollen(bee: Bee) -> void:
	var available_pollen_carry: int = bee.pollen_capacity - bee.pollen_carried
	var pollen_harvested: int = aimed_flower.harvest_pollen(available_pollen_carry)
	bee.pollen_carried += pollen_harvested

func _has_flower_or_request_one(bee: Bee) -> bool:
	if aimed_flower == null:
		bee.on_request_flower.emit(self)
		return false
	
	return true

func _is_at_flower(bee: Bee) -> bool:
	var distance_to_flower: Vector3 = aimed_flower.position - bee.global_transform.origin
	
	return distance_to_flower.length() < 0.5

func _move_to_flower(bee: Bee, delta: float) -> void:
	bee.move_component.move_to(bee, aimed_flower.position, delta)

func work(bee: Bee, delta: float) -> void:
	if bee.is_full():
		if bee.is_at_hive_cells_position():
			_deposit_pollen_to_hive_cells(bee)
		else:
			bee.move_to_hive_cells_position(delta)
	else:
		if not _has_flower_or_request_one(bee):
			return

		if _is_at_flower(bee):
			_harvest_pollen(bee)
		else:
			_move_to_flower(bee, delta)
