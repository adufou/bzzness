extends Label3D
class_name CameraFacingLabel3D

func _process(_delta: float) -> void:
	# Make the label look at the camera
	look_at(Camera.position)
	
	# Flip it 180 degrees to face the camera correctly (since -Z is forward in Godot)
	rotate_object_local(Vector3.UP, PI)
