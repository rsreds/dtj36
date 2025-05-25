extends Panel

var on_destroy: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_click") and on_destroy and GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode:
		print("Destroy!!!!!")
		var planet: PlanetNode = GameManager.object_being_dragged
		GameManager.stop_dragging()
		GameManager.planets.erase(planet)
		planet.orbit.rotation.y = 0
		planet.orbit.planet = null
		planet.free()
		GameManager.next_turn()

func _on_mouse_entered() -> void:
	on_destroy = true

func _on_mouse_exited() -> void:
	on_destroy = false
