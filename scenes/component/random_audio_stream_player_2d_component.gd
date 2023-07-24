extends AudioStreamPlayer2D
# Should be the built-in audio stream randomizer

@export var streams: Array[AudioStream]

func play_random():
	if streams == null || streams.size() == 0:
		return
	
	stream = streams.pick_random()
	play()
