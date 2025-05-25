extends Panel

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode:
				print("Harvest!!!!!")
				GameManager.stop_dragging()
