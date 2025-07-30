extends Component
class_name WorkerComponent

var _needs_honey_factory_position: bool = true
var honey_factory_position: Vector3:
	set(value):
		_needs_honey_factory_position = false
		honey_factory_position = value

func _deposit_pollen_to_honey_factory(bee: Bee) -> void:
	bee.on_deposit_pollen_to_honey_factory.emit(bee.pollen_carried)
	bee.pollen_carried = 0

func _load_pollen_from_hive_cells(bee: Bee) -> void:
	var available_pollen_carry: float = bee.pollen_capacity - bee.pollen_carried
	var pollen_to_load: float = min(available_pollen_carry, GameState.total_pollen)
	
	GameState.total_pollen -= pollen_to_load
	bee.pollen_carried += pollen_to_load

func _has_honey_factory_or_request_one(bee: Bee) -> bool:
	if _needs_honey_factory_position:
		bee.on_request_honey_factory_position.emit(self)
		return false
	
	return true

func _is_at_honey_factory_position(bee: Bee) -> bool:
	var distance_to_honey_factory_position: Vector3 = honey_factory_position - bee.global_transform.origin
	
	return distance_to_honey_factory_position.length() < 1.5

func _move_to_honey_factory_position(bee: Bee, delta: float) -> void:
	bee.move_component.move_to(bee, honey_factory_position, delta)

func work(bee: Bee, delta: float) -> void:
	if bee.is_full():
		if not _has_honey_factory_or_request_one(bee):
			return

		if _is_at_honey_factory_position(bee):
			_deposit_pollen_to_honey_factory(bee)
		else:
			_move_to_honey_factory_position(bee, delta)
	else:
		if bee.is_at_hive_cells_position():
			_load_pollen_from_hive_cells(bee)
		else:
			bee.move_to_hive_cells_position(delta)
