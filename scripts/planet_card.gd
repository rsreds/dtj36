extends PanelContainer

@export var planet: PlanetNode
@export var planet_name: String = "planet"
const PLANET = preload("res://planet.tscn")
@onready var sub_view_port: SubViewport = $HBoxContainer/SubViewportContainer/SubViewPort
@onready var label: Label = $HBoxContainer/VBoxContainer/Label

var ROTATION_SPEED : float = 0.1

func _ready() -> void:
	if planet is not PlanetNode:
		planet = PLANET.instantiate()
	planet = planet.duplicate()
	sub_view_port.add_child(planet)
	label.text = planet_name

func _physics_process(delta: float) -> void:
	planet.rotate(Vector3(0, 1, 0), ROTATION_SPEED * delta)
	
