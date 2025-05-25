extends Panel

var on_fertilise: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_click") and on_fertilise and GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode and not GameManager.is_dragging_new_planet:
		print("Fertilise!!!!!")
		GameManager.object_being_dragged.current_crop_growth_multiplier = 2.0
		GameManager.object_being_dragged.current_effects.append("Fertilised")
		GameManager.stop_dragging()

func _on_mouse_entered() -> void:
	on_fertilise = true

func _on_mouse_exited() -> void:
	on_fertilise = false
