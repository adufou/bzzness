extends Node3D

@onready var clouds = %Clouds
@onready var debris = %Debris
@onready var random_audio_player = %RandomAudioStreamPlayer
@onready var timer = %QueueFreeTimer

func _ready() -> void:
	timer.timeout.connect(queue_free)

func emit_effect() -> void:
	debris.emitting = true
	clouds.emitting = true
	random_audio_player.play_random()
