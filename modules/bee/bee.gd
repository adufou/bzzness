extends Node3D
class_name Bee

signal on_request_flower(bee: Bee)
signal on_request_hive_cells_spot(bee: Bee)
signal on_deposit_pollen(pollen: int)

var lifetime_seconds: float = GameState.bees_lifetime_seconds
var pollen_capacity: int = GameState.bees_pollen_capacity
var speed: float = GameState.bees_speed

# Rotation speed factor - higher means faster rotation
var rotation_speed: float = 2.0

var aimed_flower: Flower
var hive_cells_spot: Vector3
var pollen_carried: int = 0
var remaining_lifetime: float = lifetime_seconds

func _ready() -> void:
	on_request_flower.emit(self)
	on_request_hive_cells_spot.emit(self)

	GameState.on_update_bees_lifetime_seconds.connect(_set_lifetime_seconds)
	GameState.on_update_bees_pollen_capacity.connect(_set_pollen_capacity)
	GameState.on_update_bees_speed.connect(_set_speed)

func _process(delta: float) -> void:
	remaining_lifetime -= delta
	if (remaining_lifetime <= 0):
		queue_free()
	
	%LifetimeLabel3D.text = "%.2fs" % remaining_lifetime
	%CarryLabel3D.text = str(pollen_carried) + "/" + str(pollen_capacity)
	
	if is_full():
		if is_at_hive_cells_spot():
			deposit_pollen()
		else:
			move_to_hive_cells_spot(delta)
	else:
		if not check_flower():
			return

		if is_at_flower():
			harvest_pollen()
		else:
			move_to_flower(delta)

func _set_lifetime_seconds(value: float) -> void:
	lifetime_seconds = value

func _set_pollen_capacity(value: int) -> void:
	pollen_capacity = value

func _set_speed(value: float) -> void:
	speed = value

# Maximum roll angle in degrees (how much the bee will tilt when turning)
var max_roll_angle: float = 30.0
# Current roll angle
var current_roll: float = 0.0
# How quickly the roll transitions
var roll_transition_speed: float = 3.0

func _move(destination: Vector3, speed: float, delta: float) -> void:
	# Direction toward the destination (target direction)
	var target_direction: Vector3 = (destination - global_transform.origin).normalized()
	
	# Current forward direction of the bee (where it's facing)
	var current_direction: Vector3 = -global_transform.basis.z.normalized()
	
	# Store previous Y rotation to detect turn direction
	var previous_y_rotation = global_transform.basis.get_euler().y
	
	# Only proceed if we have a meaningful direction
	if target_direction.length_squared() > 0.001:
		# Create a temporary transform looking in our target direction
		var target_transform = global_transform.looking_at(global_transform.origin + target_direction, Vector3.UP)
		
		# Extract the rotation quaternions
		var current_quat = global_transform.basis.get_rotation_quaternion()
		var target_quat = target_transform.basis.get_rotation_quaternion()
		
		# Smoothly interpolate between current and target rotations
		var interpolated_quat = current_quat.slerp(target_quat, min(delta * rotation_speed, 1.0))
		
		# Apply the interpolated rotation
		global_transform.basis = Basis(interpolated_quat)
		
		# Update current_direction after rotation
		current_direction = -global_transform.basis.z.normalized()
		
		# Calculate how much we've rotated on Y axis this frame
		var current_y_rotation = global_transform.basis.get_euler().y
		var y_rotation_change = wrapf(current_y_rotation - previous_y_rotation, -PI, PI)
		
		# Calculate target roll based on Y rotation change
		# Positive y_rotation_change = turning left = negative roll (tilt right)
		var target_roll = -y_rotation_change * rotation_speed * 60.0
		
		# Clamp the target roll to our maximum
		target_roll = clamp(target_roll, -deg_to_rad(max_roll_angle), deg_to_rad(max_roll_angle))
		
		# Smoothly transition to the target roll
		current_roll = lerp(current_roll, target_roll, min(delta * roll_transition_speed, 1.0))
	else:
		# If we're not turning much, gradually return to upright
		current_roll = lerp(current_roll, 0.0, min(delta * roll_transition_speed, 1.0))
	
	# Apply roll to the BeeBlend node
	if %BeeBlend:
		%BeeBlend.rotation.z = current_roll
	
	# Move in the direction we're actually facing, not necessarily toward the destination
	var movement: Vector3 = current_direction * speed * delta
	
	# Update position
	global_transform.origin += movement

func check_flower() -> bool:
	if aimed_flower == null:
		on_request_flower.emit(self)
		return false
	
	return true

func deposit_pollen() -> void:
	on_deposit_pollen.emit(pollen_carried)
	pollen_carried = 0

func harvest_pollen() -> void:
	var available_pollen_carry: int = pollen_capacity - pollen_carried
	var pollen_harvested: int = aimed_flower.harvest_pollen(available_pollen_carry)
	pollen_carried += pollen_harvested

func is_full() -> bool:
	return pollen_carried >= pollen_capacity

func is_at_flower() -> bool:
	var distance_to_flower: Vector3 = aimed_flower.position - global_transform.origin
	
	return distance_to_flower.length() < 0.5

func move_to_flower(delta: float) -> void:
	_move(aimed_flower.position, speed, delta)

func is_at_hive_cells_spot() -> bool:
	var distance_to_hive_cells_spot: Vector3 = hive_cells_spot - global_transform.origin
	
	return distance_to_hive_cells_spot.length() < 0.5

func move_to_hive_cells_spot(delta: float) -> void:
	_move(hive_cells_spot, speed, delta)
