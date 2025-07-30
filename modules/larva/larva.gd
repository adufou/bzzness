extends Node3D
class_name Larva

signal on_request_hatchery_position
signal request_spawn_bee(position: Vector3)

const GROWTH_DURATION_SECONDS: float = 1
const SPEED: float = 5.0

var hatchery_position: Vector3
var growth_remaining_time: float = GROWTH_DURATION_SECONDS

# Component reference (with fallback option)
@onready var move_component: MoveComponent = $MoveComponent

func _ready() -> void:
	on_request_hatchery_position.emit()
	
	# Initialize movement component with the right speed
	move_component.speed = SPEED
	
func _process(delta: float) -> void:
	if not is_at_hatchery_position():
		move_to_hatchery_position(delta)
	else:
		progress_growth(delta)
		
func is_at_hatchery_position() -> bool:
	var distance_to_hatchery_position: Vector3 = hatchery_position - global_transform.origin
	
	return distance_to_hatchery_position.length() < 1.5

func move_to_hatchery_position(delta: float) -> void:
	move_component.move_to(self, hatchery_position, delta)

func progress_growth(delta: float) -> void:
	growth_remaining_time -= delta

	var formatted_growth_remaining_time: String = "%.2f" % growth_remaining_time
	var formatted_growth_duration_seconds: String = "%.2f" % GROWTH_DURATION_SECONDS
	
	%LarvaLabel3D.text = formatted_growth_remaining_time + "s / " + formatted_growth_duration_seconds + "s"

	if (growth_remaining_time <= 0):
		request_spawn_bee.emit(position)
		queue_free()
