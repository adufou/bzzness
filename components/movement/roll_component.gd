extends Component
class_name RollComponent

@export var roll_model_node: Node3D
@export var base_max_roll_angle: float = 90.0
@export var base_roll_transition_speed: float = 3.0
@export var roll_angle_speed_factor: float = 0.5  # How much roll angle increases with speed
@export var roll_speed_factor: float = 0.3  # How much roll transition speed increases with speed

var current_roll: float = 0.0
var previous_y_rotation: float = 0.0
var first_frame: bool = true

var movement_component: MoveComponent

func _ready() -> void:
	movement_component = get_parent()
	movement_component.on_call_next_step.connect(apply_roll)

	previous_y_rotation = movement_component.previous_y_rotation
	first_frame = false

func apply_roll(entity: Node3D, delta: float) -> void:
	var y_rotation = entity.global_transform.basis.get_euler().y
	
	# Initialize previous rotation on first frame
	if first_frame:
		previous_y_rotation = y_rotation
		first_frame = false
		return
	
	# Calculate rotation change
	var y_rotation_change = wrapf(y_rotation - previous_y_rotation, -PI, PI)
	previous_y_rotation = y_rotation
	
	# Get current speed from movement component
	var current_speed = movement_component.speed
	
	# Calculate dynamic roll parameters based on speed
	var dynamic_max_roll_angle = base_max_roll_angle + (current_speed * roll_angle_speed_factor)
	var dynamic_roll_speed = base_roll_transition_speed + (current_speed * roll_speed_factor)
	
	# Calculate target roll based on Y rotation change
	# Positive y_rotation_change = turning left = negative roll (tilt right)
	var target_roll = -y_rotation_change * 60.0
	
	# Clamp and smooth the roll using dynamic parameters
	target_roll = clamp(target_roll, -deg_to_rad(dynamic_max_roll_angle), deg_to_rad(dynamic_max_roll_angle))
	current_roll = lerp(current_roll, target_roll, min(delta * dynamic_roll_speed, 1.0))
	
	# Apply roll to target node (typically the model)
	roll_model_node.rotation.z = current_roll
