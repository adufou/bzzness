extends MovementComponent
class_name FlyComponent

@export var model_node: Node3D
@export var fly_height: float = 1.0
@export var lower_limit: float = 0.0
@export var height_adjustment_speed: float = 2.0
@export var distance_influence_factor: float = 5.0

var movement_component: MoveComponent
var target_height: float
var current_height_velocity: float = 0.0

func _ready() -> void:
	movement_component = get_parent()
	movement_component.on_call_next_movement_step.connect(adjust_height)
		
	# Initialize target height to current entity height
	target_height = fly_height

# Adjust the height of the entity based on the destination height
func adjust_height(entity: Node3D, destination: Vector3, delta: float) -> void:
	# Get horizontal distance to destination
	var horizontal_position = Vector2(entity.global_position.x, entity.global_position.z)
	var destination_horizontal = Vector2(destination.x, destination.z)
	var distance = horizontal_position.distance_to(destination_horizontal)
	
	# Calculate adjustment speed factor based on distance
	# The closer we get, the faster we adjust to match the destination height
	var distance_factor = 1.0 / max(distance / distance_influence_factor, 0.1)
	
	# Determine target height based on destination height, but respect the lower limit
	var destination_height = max(destination.y, lower_limit)
	target_height = destination_height
	
	# Calculate adjusted destination position
	var adjusted_destination = destination
	adjusted_destination.y = max(destination.y, lower_limit)
	
	# Smoothly interpolate the model's height
	var current_height = model_node.position.y
	var height_diff = target_height - current_height
	
	# Apply height adjustment with distance-based speed influence
	var adjustment_rate = height_adjustment_speed * delta * distance_factor
	var new_height = current_height + (height_diff * min(adjustment_rate, 1.0))
	
	# Apply the height change to the model
	model_node.position.y = new_height
	
	# Emit signal to notify next component in the chain
	on_call_next_movement_step.emit(entity, adjusted_destination, delta)
