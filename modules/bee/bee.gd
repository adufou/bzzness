extends Node3D
class_name Bee

signal on_request_flower(gatherer_component: GathererComponent)
signal on_request_hive_cells_position(bee: Bee)
signal on_deposit_pollen_to_hive_cells(pollen: int)
signal on_deposit_pollen_to_honey_factory(pollen: int)
signal on_request_honey_factory_position(worker_component: WorkerComponent)

var lifetime_seconds: float = GameState.bees_lifetime_seconds
var pollen_capacity: int = GameState.bees_pollen_capacity
var speed: float = GameState.bees_speed

var hive_cells_position: Vector3
var pollen_carried: int = 0
var remaining_lifetime: float = lifetime_seconds

# Components
@onready var bee_jobs_component = $BeeJobsComponent
@onready var death_effect_component = $DeathEffectComponent
@onready var move_component = $MoveComponent

func _ready() -> void:
	on_request_hive_cells_position.emit(self)


func _process(delta: float) -> void:
	remaining_lifetime -= delta
	if (remaining_lifetime <= 0):
		death_effect_component.trigger(self)
		queue_free()
	
	%LifetimeLabel3D.text = "%.2fs" % remaining_lifetime
	%CarryLabel3D.text = str(pollen_carried) + "/" + str(pollen_capacity)
	
	move_component.speed = speed
	bee_jobs_component.work(self, delta)
	
func deposit_pollen_to_hive_cells() -> void:
	on_deposit_pollen_to_hive_cells.emit(pollen_carried)
	pollen_carried = 0

func deposit_pollen_to_honey_factory() -> void:
	on_deposit_pollen_to_honey_factory.emit(pollen_carried)
	pollen_carried = 0

func is_full() -> bool:
	return pollen_carried >= pollen_capacity

func is_at_hive_cells_position() -> bool:
	var distance_to_hive_cells_position: Vector3 = hive_cells_position - global_transform.origin
	
	return distance_to_hive_cells_position.length() < 0.5

func move_to_hive_cells_position(delta: float) -> void:
	move_component.move_to(self, hive_cells_position, delta)
	
