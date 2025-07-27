extends Node3D
class_name Flower

const FLOWER_HARVESTABLE_POLLEN: int = 5

var pollen_remaining: int = FLOWER_HARVESTABLE_POLLEN

signal on_queue_free(flower: Flower)

func _ready() -> void:
	rotate_x(randf() * 0.15 * PI)
	rotate_y(randf() * 2 * PI)

func _process(delta: float) -> void:
	%RemainingPollenLabel3D.text = str(pollen_remaining)

func harvest_pollen(requested_pollen: int) -> int:
	if (pollen_remaining <= 0):
		on_queue_free.emit(self)
		queue_free()
		return 0
	
	var pollen_harvested: int = min(requested_pollen, pollen_remaining)
	pollen_remaining -= pollen_harvested

	return pollen_harvested
	
