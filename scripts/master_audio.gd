extends Node
@onready var pickup_audio_stream_player: AudioStreamPlayer = $PickupAudioStreamPlayer
@onready var resource_audio_stream_player: AudioStreamPlayer = $ResourceAudioStreamPlayer

func mute():
	AudioServer.set_bus_mute(0, true)
	AudioServer.set_bus_mute(1, true)

func unmute():
	AudioServer.set_bus_mute(0, false)
	AudioServer.set_bus_mute(1, false)
	
func play_pickup_sound()->void:
	pickup_audio_stream_player.play()
	
func play_resource_sound()->void:
	resource_audio_stream_player.play()
