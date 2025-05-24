extends SubViewportContainer
@onready var v_box_card_container: VBoxContainer = $"../SidePanel/VBoxCardContainer"

const PLANET = preload("res://planet.tscn")
const PLANET_CARD = preload("res://planet_card.tscn")
const ORBIT = preload("res://orbit.tscn")

@onready var camera: Camera3D = $SubViewport.get_camera_3d()
@onready var space_view: Node3D = $SubViewport/SpaceView
@onready var world3d: World3D = space_view.get_world_3d()

var orbits: Dictionary

var hovered_node: Node3D = null
var dragged_node: Node3D = null
var drag_offset: Vector3 = Vector3.ZERO
var original_position: Vector3 = Vector3.ZERO


func _ready() -> void:
	for card in v_box_card_container.get_children():
		card.free()
		
	for orbit in space_view.get_children():
		if orbit is OrbitNode:
			orbit.free()
	
	var card1 = PLANET_CARD.instantiate()
	var planet1 = PLANET.instantiate()
	var orbit1 = ORBIT.instantiate()
	orbit1.name = "Orbit"
	orbit1.orbit_distance = 1
	planet1.planet_size_multiplier = 3
	planet1.planet_color = Color.YELLOW
	orbit1.planet = planet1
	card1.planet = planet1
	card1.planet_name = "Pianeta1"
	v_box_card_container.add_child(card1)
	space_view.add_child(orbit1)
	
	var card2 = PLANET_CARD.instantiate()
	var planet2 = PLANET.instantiate()
	var orbit2 = ORBIT.instantiate()
	orbit2.name = "Orbit"
	orbit2.orbit_distance = 2
	planet2.planet_size_multiplier = 2
	planet2.planet_color = Color.INDIAN_RED
	orbit2.planet = planet2
	card2.planet = planet2
	card2.planet_name = "Pianeta2"
	v_box_card_container.add_child(card2)
	space_view.add_child(orbit2)
	
	
	var card3 = PLANET_CARD.instantiate()
	var planet3 = PLANET.instantiate()
	var orbit3 = ORBIT.instantiate()
	var orbit4 = ORBIT.instantiate()
	orbit3.name = "Orbit"
	orbit4.name = "Orbit"
	orbit3.orbit_distance = 3
	orbit4.orbit_distance = 4
	planet3.planet_size_multiplier = 4
	planet3.planet_color = Color.SKY_BLUE
	card3.planet = planet3
	card3.planet_name = "Pianeta3"
	orbit4.planet=planet3
	v_box_card_container.add_child(card3)
	space_view.add_child(orbit3)
	space_view.add_child(orbit4)

	for orbit_node in space_view.get_children():
		if orbit_node is OrbitNode:
			var mesh_node = orbit_node.orbit_mesh
			if mesh_node and mesh_node.mesh:
				var radius = (mesh_node.mesh.get_aabb().size.x * mesh_node.scale.x) / 2.0
				orbits[orbit_node] = radius


func _input(event: InputEvent):
	var local_pos := get_local_mouse_position()
	
	if !get_global_rect().has_point(get_global_mouse_position()):
		_clear_hover()
		return

	var from := camera.project_ray_origin(local_pos)
	var to := from + camera.project_ray_normal(local_pos) * 1000
	var query := PhysicsRayQueryParameters3D.create(from, to)
	var result := world3d.direct_space_state.intersect_ray(query)

	if result:
		var node: Node3D = result["collider"]

		if node != hovered_node:
			_clear_hover()
			_set_hover(node)

		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					dragged_node = node
					original_position = node.global_position
					drag_offset = dragged_node.global_position - result.position

	elif event is InputEventMouseMotion and dragged_node:
		var new_from = camera.project_ray_origin(local_pos)
		var new_to = new_from + camera.project_ray_normal(local_pos) * 1000
		var plane = Plane(Vector3.UP, 0)
		var intersection = plane.intersects_ray(new_from, new_to)

		if intersection:
			dragged_node.global_position = intersection + drag_offset

	else:
		if !dragged_node:
			_clear_hover()


func _process(_delta: float) -> void:
	if dragged_node and !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return_planet_to_placement()


func find_nearest_orbit() -> OrbitNode:
	var center := Vector3.ZERO
	var dragged_pos := dragged_node.global_position
	var radius := (dragged_pos - center).length()

	var closest: OrbitNode = null
	var closest_radius_diff := INF
	var minimum_distance := 10

	for o in orbits:
		var diff: float = abs(orbits[o] - radius)
		if diff < closest_radius_diff:
			closest_radius_diff = diff
			closest = o
	
	return closest


func return_planet_to_placement():
	var tween := create_tween()
	if GameManager.is_dragging_new_planet:
		var orbit := find_nearest_orbit()
		if orbit and not orbit.planet:
			orbit.planet = dragged_node
			tween.tween_property(
				dragged_node, 
				"global_position", 
				Vector3(0, 0, -orbits[orbit]), 
				0.5
			)
			return

	tween.tween_property(
		dragged_node, 
		"global_position",
		original_position, 
		0.3
	).set_trans(Tween.TRANS_SPRING)
	dragged_node = null


func _set_hover(node):
	hovered_node = node
	if hovered_node.has_method("set_glow"):
		hovered_node.set_glow(true)


func _clear_hover():
	if hovered_node and hovered_node.has_method("set_glow"):
		hovered_node.set_glow(false)
	hovered_node = null



func _on_step_button_pressed() -> void:
	for orbit in space_view.get_children():
		if orbit is OrbitNode:
			orbit.step()
