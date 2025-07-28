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
	var job_index: StringName = Jobs.keys().pick_random()
	current_job = Jobs[job_index]

func work(bee: Bee, delta: float) -> void:
	match current_job:
		Jobs.GATHERER:
			gatherer_component.work(bee, delta)
		Jobs.WORKER:
			worker_component.work(bee, delta)
