extends Control
@onready var pause_screen: Control = $PauseScreen
@onready var space_view: Node3D = $SpaceView
const PLANET_ICON = preload("res://scenes/planet_icon.tscn")
@onready var icons_control: Control = $Icons
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var game_over_screen: Control = $GameOverScreen
@onready var win_screen: Control = $WinScreen
@onready var credit_label: Label = $SidePanel/HBoxCropContainer/Panel/VBoxContainer/Label2

var button_available: bool = true

func _ready() -> void:
	GameManager.connect("win",_on_win)
	GameManager.connect("lose",_on_game_over)
	GameManager.connect("step", func (): button_available = true)

func _process(delta: float) -> void:
	credit_label.text = '%s' % GameManager.score
	
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
				
func _on_game_over()->void:
	get_tree().paused = true
	game_over_screen.visible = true

func _on_win()->void:
	get_tree().paused = true
	win_screen.visible = true

func _on_button_pressed() -> void:
	if button_available == true:
		button_available = false
		GameManager.next_turn()
