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
	query.collision_mask = 0x00008000  # Layer 16
	
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

# Generic function to find the closest entity matching a predicate within an expanding radius
# origin: The center position for the search
# entity: The Node3D from which to get the world and space state
# collision_mask: Layer mask for the physics query
# predicate_func: Function to validate if a found object meets criteria (takes a node, returns bool)
# initial_radius: Starting search radius
# max_radius: Maximum search radius
# radius_multiplier: How much to increase the radius each step
func find_closest_entity_in_radius(
	origin: Vector3, 
	entity: Node3D, 
	collision_mask: int,
	predicate_func: Callable,
	initial_radius: float = 10.0,
	max_radius: float = 100.0,
	radius_multiplier: float = 2.0
) -> Object:
	# Get the physics space state
	var space_state = entity.get_world_3d().direct_space_state
	if not space_state:
		print_debug("[WorldUtils] No valid physics space found")
		return null
	
	# Create shape for sphere cast
	var sphere_shape = SphereShape3D.new()
	var search_radius = initial_radius
	var closest_entity = null
	
	# Incrementally increase radius until we find at least one matching entity
	while search_radius <= max_radius and closest_entity == null:
		# Setup query with current radius
		var query = PhysicsShapeQueryParameters3D.new()
		sphere_shape.radius = search_radius
		query.shape = sphere_shape
		query.transform = Transform3D(Basis(), origin)
		query.collision_mask = collision_mask
		query.collide_with_bodies = true
		query.collide_with_areas = false
		
		# Execute the query
		var results = space_state.intersect_shape(query)
		
		if not results.is_empty():
			# Find the closest among results
			var closest_distance = INF
			
			for result in results:
				var candidate = result["collider"]
				# Check if the candidate matches our criteria
				if predicate_func.call(candidate):
					var distance = origin.distance_to(candidate.global_transform.origin)
					if distance < closest_distance:
						closest_distance = distance
						closest_entity = candidate
			
			# If we found a matching entity, we're done
			if closest_entity != null:
				break
		
		# Increase radius for next attempt
		search_radius *= radius_multiplier
	
	return closest_entity
