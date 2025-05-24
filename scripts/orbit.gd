class_name OrbitNode
extends Node3D

var ORBIT_MARGIN : float = 0.5
var ORBIT_GAP : float = 0.75
@export var orbit_distance:int  = 1 
@export var planet:PlanetNode
@onready var planet_marker: Marker3D = $Marker3D
@onready var orbit_mesh: MeshInstance3D = $MeshInstance3D
const PLANET = preload("res://planet.tscn")

func _ready():
	print("changing orbit position")
	planet_marker.position.x = ORBIT_MARGIN + orbit_distance * ORBIT_GAP
	orbit_mesh.mesh.inner_radius = ORBIT_MARGIN + orbit_distance * ORBIT_GAP - 0.025
	orbit_mesh.mesh.outer_radius = ORBIT_MARGIN + orbit_distance * ORBIT_GAP + 0.025
	if planet is not PlanetNode:
		planet = PLANET.instantiate()
	planet_marker.add_child(planet)
	
