extends Panel

var on_harvest: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_click") and on_harvest and GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode:
		print("Harvest!!!!!")
		GameManager.stop_dragging()

func _on_mouse_entered() -> void:
	on_harvest = true

func _on_mouse_exited() -> void:
	on_harvest = false
