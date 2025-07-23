extends Node3D
class_name Egg

signal request_spawn_larva(position: Vector3)

const HATCH_DURATION_SECONDS: float = 1

var hatch_remaining_time: float = HATCH_DURATION_SECONDS

func _process(delta: float) -> void:
	progress_hatch(delta)
	
func progress_hatch(time_delta: float) -> void:
	hatch_remaining_time -= time_delta

	var formatted_hatch_remaining_time: String = "%.2f" % hatch_remaining_time
	var formatted_hatch_duration_seconds: String = "%.2f" % HATCH_DURATION_SECONDS
	
	%EggLabel3D.text = formatted_hatch_remaining_time + "s / " + formatted_hatch_duration_seconds + "s"

	if (hatch_remaining_time <= 0):
		request_spawn_larva.emit(position)
		queue_free()
