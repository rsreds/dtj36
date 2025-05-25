extends Control
@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
@onready var texture_rect: TextureRect = $TextureRect
const SPACE_TOOLTIP = preload("res://scenes/space_tooltip.tscn")
@onready var tooltip_view: PanelContainer = $TooltipView

func _process(delta: float) -> void:
	if not GameManager.is_dragging:
		if not GameManager.is_hovering_planet:
			visible = false
			tooltip_view.visible = false
			texture_rect.visible = false
			sub_viewport_container.visible = false
		else:
			var p := GameManager.planet_being_hovered
			if p:
				visible = true
				tooltip_view.visible = true
				tooltip_view.get_node("VBoxContainer/WaterContent").text = "Water Content: %s" % p.current_water_content
				tooltip_view.get_node("VBoxContainer/Temperature").text = "Temperature: %s" % p.orbit.orbit_distance 

	if Input.is_action_just_pressed("ui_click"):
		if GameManager.object_being_dragged is PlanetCard:
			var new_planet: PlanetNode = GameManager.object_being_dragged.planet.duplicate()
			new_planet.position = Vector3.ZERO
			sub_viewport_container.free()
			sub_viewport_container = SPACE_TOOLTIP.instantiate()
			sub_viewport_container.get_child(0).add_child(new_planet)
			sub_viewport_container.visible = true
			sub_viewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
			add_child(sub_viewport_container)
			print(sub_viewport_container.get_children())
			texture_rect.visible = false
			tooltip_view.visible = false
			visible = true
		if GameManager.object_being_dragged is Crop:
			sub_viewport_container.visible = false
			set_region(texture_rect.texture)
			texture_rect.visible = true
			tooltip_view.visible = false
			visible = true
	else:
		var mouse_position = get_global_mouse_position()
		position = mouse_position


func set_region(texture: AtlasTexture) -> void:
	var crop_info = GameManager.object_being_dragged
	if crop_info.name == GameManager.crop_list[0]["name"]:
		texture.region = Rect2(199.25, 31.5, 122, 154)
	elif crop_info.name == GameManager.crop_list[1]["name"]:
		texture.region = Rect2(345.25, -2, 117, 182)
	elif crop_info.name == GameManager.crop_list[2]["name"]:
		texture.region = Rect2(0, 0, 150, 155)
	elif crop_info.name == GameManager.crop_list[3]["name"]:
		texture.region = Rect2(14.563, 201, 141, 150)
	elif crop_info.name == GameManager.crop_list[4]["name"]:
		texture.region = Rect2(174.5, 232, 164, 142)
