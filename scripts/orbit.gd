class_name OrbitNode
extends StaticBody3D

const PLANET := preload("res://scenes/planet.tscn")
const ORBIT_MARGIN := 0.5
const ORBIT_GAP := 0.75

@export var orbit_distance := 1
@onready var planet_marker: Marker3D = $Marker3D
@onready var orbit_mesh: MeshInstance3D = $OrbitMesh
@onready var collider: CollisionShape3D = $CollisionShape3D

var planet: PlanetNode = null

func _ready() -> void:
	var distance := ORBIT_MARGIN + orbit_distance * ORBIT_GAP
	planet_marker.position.x = distance
	orbit_mesh.mesh.inner_radius = distance - 0.025
	orbit_mesh.mesh.outer_radius = distance + 0.025

	var collider_mesh := orbit_mesh.mesh.duplicate()
	collider_mesh.inner_radius -= 0.25
	collider_mesh.outer_radius += 0.25
	collider.shape = collider_mesh.create_trimesh_shape()
	
	GameManager.orbits.append(self)
	
	set_alpha(0)


func step() -> void:
	if has_planets():
		var tween = create_tween()
		tween.tween_property(
			self,
			"rotation:y",
			rotation.y + PI / (orbit_distance * 2),
			0.3
		).set_trans(
			Tween.TRANS_SINE
		)

func has_planets():
	return planet_marker.get_child_count() > 0

func set_glow(val: bool) -> void:
	orbit_mesh.get_surface_override_material(0).emission_enabled = val

func set_alpha(val: float) -> void:
	var current_color:Color = orbit_mesh.get_surface_override_material(0).albedo_color
	current_color.a = 0.25
	orbit_mesh.get_surface_override_material(0).albedo_color = current_color

func reset_alpha() -> void:
	if has_planets():
		set_alpha(0.25)
	else:
		set_alpha(0)

func _on_mouse_entered() -> void:
	reset_alpha()
	if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode and GameManager.is_dragging_new_planet:
		set_alpha(0.75)
		set_glow(true)



func _on_mouse_exited() -> void:
	set_glow(false)
	if not has_planets():
		set_alpha(0.25)	
		


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("ui_click"):
		if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode and GameManager.is_dragging_new_planet and not has_planets():
			set_glow(false)
			GameManager.is_dragging_new_planet = false

			var dragged_planet = GameManager.object_being_dragged
			planet = dragged_planet.duplicate()
			planet_marker.add_child(planet)
			dragged_planet.draft()
			GameManager.stop_dragging()
