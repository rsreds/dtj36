extends Control

@onready var sound_button: Button = $Panel/VBoxContainer/Sound

func _ready() -> void:
	if GameManager.muted:
		sound_button.text = "Sound: OFF"
	else:
		sound_button.text = "Sound: ON"


func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_back_to_title_pressed() -> void:
	visible = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_sound_pressed() -> void:
	if GameManager.muted:
		GameManager.muted = false
		MasterAudio.unmute()
		sound_button.text = "Sound: ON"
	else:
		GameManager.muted = true
		MasterAudio.mute()
		sound_button.text = "Sound: OFF"
