extends Control
@onready var pause_screen: Control = $PauseScreen

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and not get_tree().paused:
		get_tree().paused = true
		pause_screen.visible = true
