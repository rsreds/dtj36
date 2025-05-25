extends Control
@onready var pause_screen: Control = $PauseScreen
@onready var space_view: Node3D = $SpaceView
const PLANET_ICON = preload("res://scenes/planet_icon.tscn")
@onready var icons_control: Control = $Icons
@onready var progress_bar: ProgressBar = $ProgressBar

func _process(delta: float) -> void:
	progress_bar.max_value = GameManager.total_steps
	progress_bar.value = GameManager.current_steps
	
	if Input.is_action_just_pressed("ui_cancel") and not get_tree().paused:
		get_tree().paused = true
		pause_screen.visible = true
	
	for child in icons_control.get_children():
		child.free()

	for child in space_view.get_children():
		if child is OrbitNode:
			if child.get_child(0).get_child_count():
				var planet:PlanetNode = child.get_child(0).get_child(0)
				var crop = planet.crop
				var camera = get_viewport().get_camera_3d()
				var icon_position = camera.unproject_position(planet.global_position)
				
				var label = Label.new()
				label.position = icon_position - label.size/2
				label.position.y -= label.size.y
				label.text = "%s Cr." % planet.accumulated_score
				icons_control.add_child(label)
				
				var region: Rect2
				if not crop:
					continue
				if crop.name == GameManager.crop_list[0]["name"]:
					region = Rect2(0,0,45,46)
				if crop.name == GameManager.crop_list[1]["name"]:
					region = Rect2(45,0,50,45)
				if crop.name == GameManager.crop_list[2]["name"]:
					region = Rect2(155,2,45,45)
				if crop.name == GameManager.crop_list[3]["name"]:
					region = Rect2(215,0,50,50)
				if crop.name == GameManager.crop_list[4]["name"]:
					region = Rect2(100,0,51,52)
				var new_icon = PLANET_ICON.instantiate()
				new_icon.position = icon_position - new_icon.size/2
				new_icon.text = "x%d" % planet.crop_amount
				var texture:AtlasTexture = new_icon.get_child(0).texture
				texture.region = region
				icons_control.add_child(new_icon)
				
