extends PanelContainer

const PLANET = preload("res://scenes/planet.tscn")

@export var planet: PlanetNode

@onready var sub_view_port: SubViewport = $HBoxContainer/SubViewportContainer/SubViewPort
@onready var name_label: Label = $HBoxContainer/VBoxContainer/Label
@onready var stats_label: Label = $HBoxContainer/VBoxContainer/Label2
@onready var effect_label: Label = $HBoxContainer/VBoxContainer/Label3

var ROTATION_SPEED : float = 0.1
var dragging = false


func _ready() -> void:
	if planet is not PlanetNode:
		planet = PlanetNode.generate_new()
		planet.planet_color = Color(randf(), randf(), randf())
		planet.planet_size_multiplier = randf_range(1, 7.5)

	sub_view_port.add_child(planet)
	
	name_label.text = planet.name
	stats_label.text = "%s planet - %s cr./step, %s water, %s influence, %s growth mult." % [
		planet.current_types[0], planet.current_score_per_step, planet.current_water_content, 
		planet.current_effects_range, planet.current_crop_growth_multiplier
	]
	effect_label.text = "%s: %s" % [planet.current_effects[0].name, planet.current_effects[0].description]


func _physics_process(delta: float) -> void:
	planet.planet_mesh.rotate(Vector3(0, 1, 0), ROTATION_SPEED * delta)


func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Clicked")
			dragging = true
			GameManager.start_dragging(planet)
			GameManager.is_dragging_new_planet = true
