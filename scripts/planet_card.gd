extends PanelContainer

const PLANET = preload("res://scenes/planet.tscn")

@export var planet: PlanetNode
@export var planet_name: String = "planet"

@onready var sub_view_port: SubViewport = $HBoxContainer/SubViewportContainer/SubViewPort
@onready var label: Label = $HBoxContainer/VBoxContainer/Label

var ROTATION_SPEED : float = 0.1
var dragging = false


func _ready() -> void:
	if planet is not PlanetNode:
		planet = PLANET.instantiate()
		planet.planet_color = Color(randf(), randf(), randf())
		planet.planet_size_multiplier = randf_range(1, 7.5)
		
	if planet is not PlanetNode:
		planet = PlanetNode.generate_new()


	sub_view_port.add_child(planet)
	label.text = planet_name


func _physics_process(delta: float) -> void:
	planet.rotate(Vector3(0, 1, 0), ROTATION_SPEED * delta)
	

func _process(delta: float) -> void:
	if sub_view_port.get_node("Planet") == null:
		queue_free()


func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Clicked")
			dragging = true
			GameManager.start_dragging(planet)
			GameManager.is_dragging_new_planet = true
