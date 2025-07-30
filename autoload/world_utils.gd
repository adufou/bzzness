extends Node3D

# Utils class, should not have methods that affect the world


func get_terrain_height_at(position: Vector3, entity: Node3D) -> float:
	# Get the physics space from the passed node or from the active viewport
	var space_state
	if entity and entity.is_inside_tree():
		space_state = entity.get_world_3d().direct_space_state
	elif Engine.get_main_loop():
		var viewport = Engine.get_main_loop().get_root()
		if viewport:
			space_state = viewport.get_world_3d().direct_space_state
	
	# If we can't get a valid physics space, return the original position
	if not space_state:
		print_debug("[WorldUtils] No valid physics space found")
		return position.y
	
	# Set up ray cast
	var from = Vector3(position.x, 100, position.z)
	var to = Vector3(position.x, -100, position.z)
	
	var query = PhysicsRayQueryParameters3D.create(from, to)
	
	# Configure query to hit everything (we'll filter later)
	query.collision_mask = 0xFFFFFFFF  # All layers
	
	# Execute raycast
	var collision = space_state.intersect_ray(query)
	
	# Debug collision result
	if collision.is_empty():
		print_debug("[WorldUtils] No collision detected at position: ", position)
	else:
		var collider = collision["collider"]
		#print_debug("[WorldUtils] Hit: ", collider.name, ", type: ", collider.get_class(), ", at height: ", collision["position"].y)
		
		# Return the height where we hit something
		return collision["position"].y
	
	# No collision found, return original height
	return position.y
