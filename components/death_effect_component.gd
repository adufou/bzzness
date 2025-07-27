extends Node
class_name DeathEffectComponent

@export var death_effect_scene: PackedScene
@export var entity_collision_shape: CollisionShape3D

func trigger(entity: Node3D) -> void:
	var death_effect = death_effect_scene.instantiate()
	death_effect.position = entity.position
	
	entity.add_sibling(death_effect)
	
	death_effect.emit_effect()
