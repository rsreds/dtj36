extends Panel

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode:
				print("Fertilise!!!!!")
				GameManager.object_being_dragged.current_crop_growth_multiplier = 2.0
				GameManager.object_being_dragged.current_effects.append()
				GameManager.stop_dragging()
