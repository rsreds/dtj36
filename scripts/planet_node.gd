extends Node3D

var MIN_SIZE:float = 0.2
var DEFAULT_SIZE: float = 0.10
@export var planet_size_multiplier: int = 1
@export_color_no_alpha var planet_color:Color = Color.AQUA

func _ready() -> void:
	var new_size = MIN_SIZE + planet_size_multiplier * DEFAULT_SIZE
	scale = Vector3(new_size, new_size, new_size)
	var planet_mesh = $MeshInstance3D as MeshInstance3D
	var material = planet_mesh.get_surface_override_material(0)
	var new_material = material.duplicate()
	planet_mesh.set_surface_override_material(0, new_material)
	new_material.albedo_color = planet_color
