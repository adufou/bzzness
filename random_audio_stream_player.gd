extends AudioStreamPlayer3D
class_name RandomAudioStreamPlayer

@export var audio_streams: Array[AudioStream]

func play_random() -> void:
	stream = audio_streams.pick_random()
	play()
