extends SubViewportContainer

@onready var camera: Camera3D = $SubViewport.get_camera_3d()
@onready var world3d: World3D = $SubViewport/Node3D.get_world_3d()

var hovered_node: Node3D = null
var dragged_node: Node3D = null
var drag_offset: Vector3 = Vector3.ZERO
var original_position: Vector3 = Vector3.ZERO

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


func _process(delta: float) -> void:
	if dragged_node and !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return_to_origin()


func return_to_origin():
	var tween := create_tween()
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
