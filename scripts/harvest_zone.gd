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
	var crop_name = planet.crop.name
	var target_position = Vector2(1000,600)
	planet.crop = null
	for i in range(amount):
		for crop in GameManager.crop_list:
			if crop["name"] == crop_name:
				crop["amount"] += 1
		var crop_icon = CROP_ICON.instantiate()
		crop_icon.z_index = 99
		var texture = crop_icon.get_child(0).texture
		set_region(crop_name, texture)
		add_child(crop_icon)
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
	GameManager.next_turn()
		
func set_region(crop_name, texture: AtlasTexture) -> void:
	var region
	if crop_name == GameManager.crop_list[0]["name"]:
		region = Rect2(0,0,45,46)
	if crop_name == GameManager.crop_list[1]["name"]:
		region = Rect2(45,0,50,45)
	if crop_name == GameManager.crop_list[2]["name"]:
		region = Rect2(155,2,45,45)
	if crop_name == GameManager.crop_list[3]["name"]:
		region = Rect2(215,0,50,50)
	if crop_name == GameManager.crop_list[4]["name"]:
		region = Rect2(100,0,51,52)
	texture.region = region
