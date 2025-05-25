extends Panel

var on_destroy: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_click") and on_destroy and GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode:
		print("Destroy!!!!!")
		var planet = GameManager.object_being_dragged
		GameManager.stop_dragging()
		planet.queue_free()

func _on_mouse_entered() -> void:
	on_destroy = true

func _on_mouse_exited() -> void:
	on_destroy = false
