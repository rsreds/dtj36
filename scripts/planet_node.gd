class_name PlanetNode
extends StaticBody3D

const MIN_SIZE: float = 0.2
const DEFAULT_SIZE: float = 0.10

@export var planet_size_multiplier: int = 1
@export_color_no_alpha var planet_color: Color = Color.AQUA

@onready var planet_mesh = $MeshInstance3D


func _ready() -> void:
	var new_size = MIN_SIZE + planet_size_multiplier * DEFAULT_SIZE
	scale = Vector3.ONE * new_size
	planet_mesh.get_surface_override_material(0).albedo_color = planet_color


func set_glow(val: bool) -> void:
	planet_mesh.get_surface_override_material(0).emission_enabled = val
