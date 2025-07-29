extends Component
class_name MovementComponent

# Base class for movement components
signal on_call_next_movement_step(entity: Node3D, destination: Vector3, delta: float)
