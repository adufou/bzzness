extends Node3D
class_name Larva

signal on_request_hatchery_spot
signal request_spawn_bee(position: Vector3)

const GROWTH_DURATION_SECONDS: float = 1
const SPEED: float = 5.0

var hatchery_spot: Vector3
var growth_remaining_time: float = GROWTH_DURATION_SECONDS

func _ready() -> void:
	on_request_hatchery_spot.emit()
	
func _process(delta: float) -> void:
	if not is_at_hatchery_spot():
		move_to_hatchery_spot(delta)
	else:
		progress_growth(delta)
		
func is_at_hatchery_spot() -> bool:
	var distance_to_hatchery_spot: Vector3 = hatchery_spot - global_transform.origin
	
	return distance_to_hatchery_spot.length() < 0.5

func move_to_hatchery_spot(delta: float) -> void:
	var direction: Vector3 = (hatchery_spot - global_transform.origin).normalized()
	var movement: Vector3 = direction * SPEED * delta

	global_transform.origin += movement

func progress_growth(delta: float) -> void:
	growth_remaining_time -= delta

	var formatted_growth_remaining_time: String = "%.2f" % growth_remaining_time
	var formatted_growth_duration_seconds: String = "%.2f" % GROWTH_DURATION_SECONDS
	
	%LarvaLabel3D.text = formatted_growth_remaining_time + "s / " + formatted_growth_duration_seconds + "s"

	if (growth_remaining_time <= 0):
		request_spawn_bee.emit(position)
		queue_free()
