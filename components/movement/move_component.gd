extends Component
class_name MoveComponent

@export var speed: float = 5.0
@export var rotation_speed: float = 5.0

# For tracking previous rotation state
var previous_y_rotation: float = 0.0

func _ready() -> void:
	# Initialize with random rotation for the parent entity
	randomize()
	var random_angle = randf_range(0, 2 * PI)
	var random_basis = Basis(Vector3.UP, random_angle)
	
	# Apply random rotation to parent entity if it's a Node3D
	if get_parent() is Node3D:
		get_parent().global_transform.basis = random_basis
		previous_y_rotation = random_angle

func move_to(entity: Node3D, destination: Vector3, delta: float) -> void:
	# Get the direction to the destination
	var target_direction = (destination - entity.global_transform.origin).normalized()
	
	if target_direction.length_squared() > 0.001:
		# Create a temporary transform looking in our target direction
		var target_transform = entity.global_transform.looking_at(
			entity.global_transform.origin + target_direction, 
			Vector3.UP
		)
		
		# Extract quaternions
		var current_quat = entity.global_transform.basis.get_rotation_quaternion()
		var target_quat = target_transform.basis.get_rotation_quaternion()
		
		# Smoothly interpolate rotation
		var interpolated_quat = current_quat.slerp(target_quat, min(delta * rotation_speed, 1.0))
		
		# Apply the interpolated rotation
		entity.global_transform.basis = Basis(interpolated_quat)
	
	# Get current forward direction (where the entity is facing)
	var forward_direction = -entity.global_transform.basis.z.normalized()
	
	# Move in the direction the entity is facing
	var movement = forward_direction * speed * delta
	entity.global_transform.origin += movement

	on_call_next_step.emit(entity, delta)
