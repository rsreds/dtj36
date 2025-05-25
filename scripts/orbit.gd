class_name OrbitNode
extends StaticBody3D

const PLANET = preload("res://scenes/planet.tscn")
const ORBIT_MARGIN : float = 0.5
const ORBIT_GAP : float = 0.75

@export var orbit_distance: int = 1 
@onready var planet_marker: Marker3D = $Marker3D
@onready var orbit_mesh: MeshInstance3D = $OrbitMesh
@onready var collider: CollisionShape3D = $CollisionShape3D

var planet: PlanetNode
var starting_position: Vector3

func _ready():
	planet_marker.position.x = ORBIT_MARGIN + orbit_distance * ORBIT_GAP
	orbit_mesh.mesh.inner_radius = ORBIT_MARGIN + orbit_distance * ORBIT_GAP - 0.025
	orbit_mesh.mesh.outer_radius = ORBIT_MARGIN + orbit_distance * ORBIT_GAP + 0.025
	
	starting_position = Vector3(0, 1, -(orbit_mesh.mesh.get_aabb().size.x * orbit_mesh.scale.x) / 2.0)
	
	var collider_mesh: TorusMesh = orbit_mesh.mesh.duplicate()
	collider_mesh.inner_radius = collider_mesh.inner_radius - 0.25
	collider_mesh.outer_radius = collider_mesh.outer_radius + 0.25
	collider.shape = collider_mesh.create_trimesh_shape()


func step():
	var angle = PI/(5*orbit_distance)
	rotate(Vector3(0,1,0), angle)


func set_glow(val: bool) -> void:
	orbit_mesh.get_surface_override_material(0).emission_enabled = val


func _on_mouse_entered() -> void:
	print("Mouse entered")
	if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode and GameManager.is_dragging_new_planet:
		set_glow(true)


func _on_mouse_exited() -> void:
	set_glow(false)


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode and not planet and GameManager.is_dragging_new_planet:
				set_glow(false)
				GameManager.is_dragging_new_planet = false
				GameManager.object_being_dragged.reparent(self)
				GameManager.object_being_dragged.camera = get_viewport().get_camera_3d()
				GameManager.object_being_dragged.global_position = starting_position
				planet = GameManager.object_being_dragged
				PlanetManager.draft_planet(GameManager.object_being_dragged)
				GameManager.stop_dragging()
