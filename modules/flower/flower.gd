extends Node3D
class_name Flower

const FLOWER_HARVESTABLE_POLLEN: float = 250.0

var pollen_remaining: float = FLOWER_HARVESTABLE_POLLEN

signal on_queue_free(flower: Flower)

func _ready() -> void:
	rotate_x(randf() * 0.15 * PI)
	rotate_y(randf() * 2 * PI)

func _process(delta: float) -> void:
	%RemainingPollenLabel3D.text = "%.2f" % pollen_remaining

func harvest_pollen(requested_pollen: float) -> float:
	if (pollen_remaining <= 0):
		on_queue_free.emit(self)
		queue_free()
		return 0
	
	var pollen_harvested: float = min(requested_pollen, pollen_remaining)
	pollen_remaining -= pollen_harvested

	return pollen_harvested
	
