extends Component
class_name BeeJobsComponent

@export var gatherer_component: GathererComponent
@export var worker_component: WorkerComponent 

enum Jobs {
	GATHERER,
	WORKER
}

var current_job: Jobs

func _ready() -> void:
	current_job = _pick_job()
	print_debug("Current job: " + str(current_job))

func _pick_job() -> Jobs:
	var total_weight: float = 0
	for job_name: String in Jobs.keys():
		total_weight += GameState.get_job_weight(Jobs[job_name])
	
	# Generate a random value between 0 and total_weight
	var random_value = randf_range(0, total_weight)
	
	# Iterate through jobs until we find the one that corresponds to our random value
	var current_weight = 0
	for job_name: String in Jobs.keys():
		current_weight += GameState.get_job_weight(Jobs[job_name])
		if random_value <= current_weight:
			return Jobs[job_name]

	print_debug("No job found with weight: " + str(random_value) + " / " + str(total_weight))
	return Jobs.GATHERER

func work(bee: Bee, delta: float) -> void:
	match current_job:
		Jobs.GATHERER:
			gatherer_component.work(bee, delta)
		Jobs.WORKER:
			worker_component.work(bee, delta)
