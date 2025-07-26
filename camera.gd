extends Camera3D
class_name Camera

# Camera movement settings
@export var movement_speed: float = 5.0  # Speed multiplier for camera movement
@export var drag_sensitivity: float = 0.01  # How sensitive the drag motion is
@export var invert_x: bool = false  # Invert X axis movement
@export var invert_z: bool = false  # Invert Z axis movement
@export var bounds_min: Vector2 = Vector2(-15, -15)  # Minimum X,Z position
@export var bounds_max: Vector2 = Vector2(15, 15)    # Maximum X,Z position

# Input tracking variables
var is_dragging: bool = false
var last_drag_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Make sure we can process input
	set_process_input(true)

func _input(event: InputEvent) -> void:
	# Handle mouse input for development
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = event.pressed
			if is_dragging:
				last_drag_position = event.position
	
	# Handle mouse motion while dragging
	elif event is InputEventMouseMotion and is_dragging:
		_handle_drag(event.position)
	
	# Handle touch input for mobile
	elif event is InputEventScreenTouch:
		is_dragging = event.pressed
		if is_dragging:
			last_drag_position = event.position
	
	# Handle touch drag motion
	elif event is InputEventScreenDrag:
		_handle_drag(event.position)

func _handle_drag(current_position: Vector2) -> void:
	# Calculate drag delta
	var delta_drag = current_position - last_drag_position
	last_drag_position = current_position
	
	# Apply drag sensitivity and inversion settings
	var move_x = delta_drag.x * drag_sensitivity * (-1 if invert_x else 1)
	var move_z = -delta_drag.y * drag_sensitivity * (-1 if invert_z else 1)  # Negate Y drag for correct up-down movement
	
	# Get the camera's basis vectors to account for rotation
	var forward_dir = -global_transform.basis.z.normalized()
	var right_dir = global_transform.basis.x.normalized()
	
	# We only care about the horizontal components (xz-plane)
	# Zero out the y component and renormalize
	forward_dir.y = 0
	right_dir.y = 0
	
	if forward_dir.length() > 0.001:
		forward_dir = forward_dir.normalized()
	if right_dir.length() > 0.001:
		right_dir = right_dir.normalized()
	
	# Calculate movement vector based on camera orientation
	# Negate the movement to fix the inverted directions
	var movement = -(right_dir * move_x + forward_dir * move_z)
	
	# Move the camera
	var new_position = global_transform.origin
	new_position += movement * movement_speed
	
	# Apply bounds
	new_position.x = clamp(new_position.x, bounds_min.x, bounds_max.x)
	new_position.z = clamp(new_position.z, bounds_min.y, bounds_max.y)
	
	# Update camera position
	global_transform.origin = new_position
