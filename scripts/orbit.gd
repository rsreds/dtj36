class_name OrbitNode
extends StaticBody3D

const PLANET := preload("res://scenes/planet.tscn")
const ORBIT_MARGIN := 0.5
const ORBIT_GAP := 0.75

@export var orbit_distance := 1
@onready var planet_marker: Marker3D = $Marker3D
@onready var orbit_mesh: MeshInstance3D = $OrbitMesh
@onready var collider: CollisionShape3D = $CollisionShape3D

var planet: PlanetNode
var starting_position := Vector3.ZERO

func _ready() -> void:
	var distance := ORBIT_MARGIN + orbit_distance * ORBIT_GAP
	planet_marker.position.x = distance
	orbit_mesh.mesh.inner_radius = distance - 0.025
	orbit_mesh.mesh.outer_radius = distance + 0.025

	starting_position = Vector3(0, 1, -(orbit_mesh.mesh.get_aabb().size.x * orbit_mesh.scale.x) / 2.0)

	var collider_mesh := orbit_mesh.mesh.duplicate()
	collider_mesh.inner_radius -= 0.25
	collider_mesh.outer_radius += 0.25
	collider.shape = collider_mesh.create_trimesh_shape()
	
	GameManager.orbits.append(self)


func step() -> void:
	await create_tween().tween_property(self, "rotation:y", rotation.y + (PI / orbit_distance), 0.3).set_trans(Tween.TRANS_SINE)
	#rotate(Vector3.UP, PI / orbit_distance)


func set_glow(val: bool) -> void:
	orbit_mesh.get_surface_override_material(0).emission_enabled = val


func _on_mouse_entered() -> void:
	if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode and GameManager.is_dragging_new_planet:
		set_glow(true)


func _on_mouse_exited() -> void:
	set_glow(false)


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode and GameManager.is_dragging_new_planet and not planet:
			set_glow(false)
			GameManager.is_dragging_new_planet = false

			var dragged_planet = GameManager.object_being_dragged
			planet = dragged_planet
			dragged_planet.reparent(self)
			dragged_planet.global_position = starting_position
			dragged_planet.draft()
			

			GameManager.stop_dragging()
