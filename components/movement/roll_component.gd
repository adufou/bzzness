extends Component
class_name RollComponent

@export var max_roll_angle: float = 30.0
@export var roll_transition_speed: float = 3.0
#@export var roll_node_path: NodePath = "BeeBlend"  # Default to BeeBlend for bees

var current_roll: float = 0.0
var previous_y_rotation: float = 0.0
var first_frame: bool = true

func _ready() -> void:
	var movement_component: MoveComponent = get_parent()
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
	
	# Calculate target roll based on Y rotation change
	# Positive y_rotation_change = turning left = negative roll (tilt right)
	var target_roll = -y_rotation_change * 60.0
	
	# Clamp and smooth the roll
	target_roll = clamp(target_roll, -deg_to_rad(max_roll_angle), deg_to_rad(max_roll_angle))
	current_roll = lerp(current_roll, target_roll, min(delta * roll_transition_speed, 1.0))
	
	# Apply roll to target node (typically the model)
	#var roll_node = entity.get_node_or_null(roll_node_path)
	#if roll_node:
		#roll_node.rotation.z = current_roll
	entity.rotation.z = -current_roll
