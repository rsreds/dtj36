extends Panel

const CROP_ICON = preload("res://scenes/crop_icon.tscn")
var on_harvest: bool = false

var harvesting: bool = false
signal done_harvesting

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_click") and on_harvest and GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode:
		var planet = GameManager.object_being_dragged
		if planet.crop:
			harvest_resources(planet)
		GameManager.stop_dragging()

func _on_mouse_entered() -> void:
	on_harvest = true

func _on_mouse_exited() -> void:
	on_harvest = false

func harvest_resources(planet:PlanetNode):
	harvesting = true
	var amount = planet.crop_amount
	amount = 10
	var crop_name = planet.crop.name
	var target_position = Vector2(1000,600)
	for i in range(amount):
		for crop in GameManager.crop_list:
			if crop["name"] == crop_name:
				crop["amount"] += 1
		var crop_icon = CROP_ICON.instantiate()
		add_child(crop_icon)
		crop_icon.z_index = 99
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, 5)
		var rndY = rng.randi_range(0, 5)
		var mouse_position = get_global_mouse_position() + Vector2(rndX,rndY)
		crop_icon.global_position = mouse_position
		crop_icon.move_to_position_and_free(target_position)
		await get_tree().create_timer(0.03).timeout
	harvesting = false
	await get_tree().create_timer(0.5).timeout
	done_harvesting.emit()
		
	
