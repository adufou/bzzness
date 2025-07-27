extends Camera3D
class_name Camera

# Camera movement settings
@export_group("Bounds")
@export var bounds_min: Vector2 = Vector2(-15, -15)  # Minimum X,Z position
@export var bounds_max: Vector2 = Vector2(15, 15)    # Maximum X,Z position

@export_group("Sensibility")
@export var drag_sensitivity: float = 0.01  # How sensitive the drag motion is
@export var pinch_sensitivity: float = 0.01  # Sensitivity for pinch gestures

@export_group("Speed")
@export var movement_speed: float = 5.0  # Speed multiplier for camera movement

@export_group("Transfom")

@export_group("Zoom")
@export var zoom_speed: float = 0.1  # Speed of zooming
@export var min_zoom: float = 5.0   # Minimum zoom distance (closest)
@export var max_zoom: float = 20.0  # Maximum zoom distance (furthest)

# Input tracking variables
var is_dragging: bool = false
var last_drag_position: Vector2 = Vector2.ZERO

# Pinch-to-zoom variables
var pinch_distance_start: float = 0.0
var is_pinching: bool = false

func _ready() -> void:
	# Make sure we can process input
	set_process_input(true)

func _handle_desktop_input(input_event_mouse: InputEventMouse) -> void:
	if input_event_mouse is InputEventMouseButton:
		if input_event_mouse.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = input_event_mouse.pressed
			if is_dragging:
				last_drag_position = input_event_mouse.position
			
		# Handle mouse wheel for zooming
		elif input_event_mouse.button_index == MOUSE_BUTTON_WHEEL_UP:
			_zoom_camera(zoom_speed)
		
		elif input_event_mouse.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_zoom_camera(-zoom_speed)
	
	# Handle mouse motion while dragging
	elif input_event_mouse is InputEventMouseMotion and is_dragging:
		_handle_drag(input_event_mouse.position)

func _handle_mobile_input(input_event_from_window: InputEventFromWindow) -> void:
	if input_event_from_window is InputEventScreenTouch:
		if input_event_from_window.index == 0:  # First finger
			is_dragging = input_event_from_window.pressed
			if is_dragging:
				last_drag_position = input_event_from_window.position
				
		# Handle multi-touch for pinch-to-zoom
		if input_event_from_window.index == 1:  # Second finger
			if input_event_from_window.pressed:
				# Start pinch - store the position of the second touch
				var first_touch_pos = last_drag_position  # First finger position
				var second_touch_pos = input_event_from_window.position  # Second finger position
				pinch_distance_start = first_touch_pos.distance_to(second_touch_pos)
				is_pinching = true
			else:
				is_pinching = false

	# Handle touch drag motion
	elif input_event_from_window is InputEventScreenDrag:
		# Handle single finger drag for camera movement
		if input_event_from_window.index == 0 and not is_pinching:
			_handle_drag(input_event_from_window.position)
		
		# Handle pinch-to-zoom with screen drag events
		if is_pinching and input_event_from_window.index == 1:  # Second finger moving
			var first_touch_pos = last_drag_position  # First finger position
			var second_touch_pos = input_event_from_window.position  # Second finger position
			var current_distance = first_touch_pos.distance_to(second_touch_pos)
			var pinch_delta = (pinch_distance_start - current_distance) * pinch_sensitivity
			
			_zoom_camera(pinch_delta)
			pinch_distance_start = current_distance

func _input(event: InputEvent) -> void:
	# Handle mouse input for development
	if event is InputEventMouse:
		_handle_desktop_input(event)
	
	# Handle touch input for mobile
	elif event is InputEventFromWindow:
		_handle_mobile_input(event)
		
func _zoom_camera(zoom_amount: float) -> void:
	# Get the current position and forward direction
	var current_position = global_transform.origin
	var forward_dir = -global_transform.basis.z.normalized()
	
	# Calculate new position by moving along the forward direction
	var new_position = current_position + forward_dir * zoom_amount
	
	# Calculate distance from origin to ensure we stay within zoom limits
	var distance_to_target = new_position.length()
	
	# Clamp the zoom distance
	if distance_to_target < min_zoom:
		new_position = new_position.normalized() * min_zoom
	elif distance_to_target > max_zoom:
		new_position = new_position.normalized() * max_zoom
	
	# Update camera position
	global_transform.origin = new_position

func _handle_drag(current_position: Vector2) -> void:
	# Calculate drag delta
	var delta_drag = current_position - last_drag_position
	last_drag_position = current_position
	
	# Apply drag sensitivity and inversion settings
	var move_x = delta_drag.x * drag_sensitivity
	var move_z = -delta_drag.y * drag_sensitivity
	
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
