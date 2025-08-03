extends Node

@export var world_scene: PackedScene

var _world: World

func _ready() -> void:
	Reset.on_world_restart_requested.connect(restart)
	
	initialize()
	
func initialize() -> void:
	_world = world_scene.instantiate()
	add_child(_world)

func restart() -> void:
	_world.queue_free()
	initialize()

	Reset.on_world_restart_completed.emit()
