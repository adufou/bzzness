extends Node
class_name MovementComponent

@export var speed: float = 5.0
@export var rotation_speed: float = 5.0

func move_to(entity: Node3D, destination: Vector3, delta: float) -> float:
	# Get the direction to the destination
	var target_direction = (destination - entity.global_transform.origin).normalized()
	
	# Get current y rotation before any changes
	var current_y_rotation = entity.global_transform.basis.get_euler().y
	
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
		
		# Update current_y_rotation after rotation
		current_y_rotation = entity.global_transform.basis.get_euler().y
	
	# Get current forward direction (where the entity is facing)
	var forward_direction = -entity.global_transform.basis.z.normalized()
	
	# Move in the direction the entity is facing
	var movement = forward_direction * speed * delta
	entity.global_transform.origin += movement
	
	# Return the current Y rotation for roll calculation
	return current_y_rotation
