class_name PlanetNode
extends StaticBody3D

const MIN_SIZE: float = 0.2
const DEFAULT_SIZE: float = 0.10
const PLANET_SCENE = preload("res://scenes/planet.tscn")

@export var planet_size_multiplier: int = 1
@export_color_no_alpha var planet_color: Color = Color.AQUA

@onready var planet_mesh = $MeshInstance3D
@onready var camera: Camera3D = get_viewport().get_camera_3d()

var is_being_dragged: bool = false
var drag_offset := Vector3.ZERO
var original_position := Vector3.ZERO

func _ready() -> void:
	var new_size = MIN_SIZE + planet_size_multiplier * DEFAULT_SIZE
	scale = Vector3.ONE * new_size
	planet_mesh.get_surface_override_material(0).albedo_color = planet_color


func _process(delta):
	if is_being_dragged and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos := get_viewport().get_mouse_position()
		var from := camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * 1000
		var plane := Plane(Vector3.UP, 1)
		var hit = plane.intersects_ray(from, to)
		if hit:
			global_position = hit + drag_offset
	elif is_being_dragged:
		is_being_dragged = false
		GameManager.stop_dragging()
		_return_to_place()


func set_glow(val: bool) -> void:
	planet_mesh.get_surface_override_material(0).emission_enabled = val


func _on_mouse_entered() -> void:
	set_glow(true)
	if GameManager.is_dragging and GameManager.object_being_dragged is Crop:
		crop = GameManager.object_being_dragged
		GameManager.stop_dragging()


func _on_mouse_exited() -> void:
	set_glow(false)


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_being_dragged = true
			GameManager.start_dragging(self)
			drag_offset = global_position - event_position
			original_position = global_position
		else:
			is_being_dragged = false
			GameManager.stop_dragging()
			_return_to_place()


func _return_to_place():
	var tween = create_tween()
	tween.tween_property(self, "global_position", original_position, 0.3).set_trans(Tween.TRANS_SPRING)

enum PlanetType {
	RED,
	YELLOW,
	BLUE,
	GREEN,
	WHITE
}

enum WaterContent {
	LOW,
	MEDIUM,
	HIGH
}

# Features a base and a current value for every member, since certain effects
# might change those members on a temporary basis (proximity, orbit rank, etc.)
# Ultimately, we shouldn't assume a change to a value is permanent.

var base_types: Array[PlanetType]
var current_types: Array[PlanetType]

var base_effects: Array[BasePlanetEffect]
var current_effects: Array[BasePlanetEffect]
var base_effects_range: int
var current_effects_range: int
	
var base_water_content: WaterContent
var current_water_content: WaterContent

var base_score_per_step: int
var current_score_per_step: int

var crop: Crop
var base_crop_growth_multiplier: float
var current_crop_growth_multiplier: float
var crop_amount: int


static func generate_new() -> PlanetNode:
	var instance := PLANET_SCENE.instantiate()
	
	instance.name = String.num_uint64(randi())
	
	instance.base_types = [randi_range(0, PlanetType.values().size()) as PlanetType]
	instance.current_types = instance.base_types.duplicate()
	
	instance.base_effects = [HydratingPlanetEffect.new()]
	instance.current_effects = instance.base_effects.duplicate()
	instance.base_effects_range = randi_range(10, 100)
	instance.current_effects_range = instance.base_effects_range
	
	instance.base_water_content = randi_range(0, WaterContent.values().size()) as WaterContent
	instance.current_water_content = instance.base_water_content
	
	return instance
