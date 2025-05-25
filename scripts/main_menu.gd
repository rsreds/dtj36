extends Control
@onready var background_view: Node3D = $BackgroundView
@onready var sound_button: Button = $Panel/VBoxContainer/Sound

func _physics_process(delta: float) -> void:
	for child in background_view.get_children():
		if child is OrbitNode:
			child.rotate(Vector3.UP, delta * PI / (5*child.orbit_distance))

func _ready() -> void:
	if GameManager.muted:
		sound_button.text = "Sound: OFF"
	else:
		sound_button.text = "Sound: ON"


func _on_sound_pressed() -> void:
	if GameManager.muted:
		GameManager.muted = false
		MasterAudio.unmute()
		sound_button.text = "Sound: ON"
	else:
		GameManager.muted = true
		MasterAudio.mute()
		sound_button.text = "Sound: OFF"


func _on_tutorial_pressed() -> void:
	GameManager.reset()
	GameManager.level = 0
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_level_1_pressed() -> void:
	GameManager.reset()
	GameManager.level = 1
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_level_2_pressed() -> void:
	GameManager.reset()
	GameManager.level = 2
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_level_3_pressed() -> void:
	GameManager.reset()
	GameManager.level = 3
	get_tree().change_scene_to_file("res://scenes/main.tscn")
