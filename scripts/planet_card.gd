class_name PlanetCard
extends PanelContainer

@export var planet: PlanetNode:
	set(value):
		if value == null:
			planet.queue_free()

		planet = value
		if planet:
			sub_view_port.add_child(planet)
			name_label.text = planet.name
			stats_label.text = "%s planet - %s cr./step, %s water, %s influence, %s growth mult." % [
				planet.current_types[0], planet.current_score_per_step, planet.current_water_content, 
				planet.current_effects_range, planet.current_crop_growth_multiplier
			]
			effect_label.text = "%s" % planet.current_effects[0].name
			tooltip_text = "%s: %s" % planet.current_effects[0].description

@onready var sub_view_port: SubViewport = $HBoxContainer/SubViewportContainer/SubViewPort
@onready var name_label: Label = $HBoxContainer/VBoxContainer/Label
@onready var stats_label: Label = $HBoxContainer/VBoxContainer/Label2
@onready var effect_label: Label = $HBoxContainer/VBoxContainer/Label3

var this_is_dragging: bool = false
var ROTATION_SPEED : float = 0.1

func _ready() -> void:
	planet = DeckManager.pop_top_planet()

func _physics_process(delta: float) -> void:
	if planet:
		planet.planet_mesh.rotate(Vector3(0, 1, 0), ROTATION_SPEED * delta)


func _gui_input(event):
	if event.is_action_pressed("ui_click"):
		this_is_dragging = true
		GameManager.is_dragging = true
		GameManager.start_dragging(self)


func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_click"):
		if GameManager.is_dragging and this_is_dragging:
			GameManager.stop_dragging()
			this_is_dragging = false
			print("Dropped planet from card to be returned ", planet.name)
		pivot_offset = Vector2(size.x/2, size.y)
		scale = Vector2(1,1)
	
	if planet == null:
		planet = DeckManager.pop_top_planet()


func _on_mouse_entered() -> void:
	if not GameManager.is_dragging:
		pivot_offset = Vector2(size.x, size.y/2)
		scale = Vector2(1.05,1.1)


func _on_mouse_exited() -> void:
	if not GameManager.is_dragging:
		pivot_offset = Vector2(size.x, size.y/2)
		scale = Vector2(1,1)
