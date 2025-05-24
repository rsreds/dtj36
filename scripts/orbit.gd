class_name OrbitNode
extends Node3D

const PLANET = preload("res://planet.tscn")
const ORBIT_MARGIN : float = 0.5
const ORBIT_GAP : float = 0.75

@export var orbit_distance: int = 1 
@export var planet: PlanetNode
@onready var planet_marker: Marker3D = $Marker3D
@onready var orbit_mesh: MeshInstance3D = $OrbitMesh


func _ready():
	planet_marker.position.x = ORBIT_MARGIN + orbit_distance * ORBIT_GAP
	orbit_mesh.mesh.inner_radius = ORBIT_MARGIN + orbit_distance * ORBIT_GAP - 0.025
	orbit_mesh.mesh.outer_radius = ORBIT_MARGIN + orbit_distance * ORBIT_GAP + 0.025

	planet_marker.add_child(planet)


func step():
	var angle = PI/(5*orbit_distance)
	rotate(Vector3(0,1,0), angle)
