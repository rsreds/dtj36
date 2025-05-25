class_name PlanetNode
extends StaticBody3D

const MIN_SIZE := 0.2
const DEFAULT_SIZE := 0.1
const PLANET_SCENE := preload("res://scenes/planet.tscn")

enum PlanetType { RED, YELLOW, BLUE, GREEN, WHITE }
enum WaterContent { LOW, MEDIUM, HIGH }

@export var planet_size_multiplier := 1
@export_color_no_alpha var planet_color := Color.AQUA

@onready var planet_mesh: MeshInstance3D = $MeshInstance3D
@onready var range_mesh: MeshInstance3D = $RangeMesh
@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var material := planet_mesh.get_surface_override_material(0)

var is_being_dragged := false
var drag_offset := Vector3.ZERO
var original_position := Vector3.ZERO
var crop: Crop
var orbit: OrbitNode

var base_types: Array[PlanetType]
var current_types: Array[PlanetType]

var base_effects: Array[BasePlanetEffect]
var current_effects: Array[BasePlanetEffect]
var base_effects_range := 0
var current_effects_range := 0:
	set(value):
		current_effects_range = value
		if range_mesh:
			range_mesh.mesh.top_radius = float(value / 20)

var base_water_content: WaterContent
var current_water_content: WaterContent

var base_score_per_step := 0
var current_score_per_step := 0

var base_crop_growth_multiplier := 1.0
var current_crop_growth_multiplier := 1.0
var crop_amount := 0

var on_planet: bool = false

func _ready() -> void:
	var size = MIN_SIZE + planet_size_multiplier * DEFAULT_SIZE
	planet_mesh.scale = Vector3.ONE * size
	material.albedo_color = planet_color
	range_mesh.get_surface_override_material(0).albedo_color = Color(planet_color.r, planet_color.g, planet_color.b, 0.33)
	range_mesh.mesh.top_radius = base_effects_range

func _process(_delta: float) -> void:
	if is_being_dragged:
		if Input.is_action_pressed("ui_click"):
			var mouse_pos := get_viewport().get_mouse_position()
			var from := camera.project_ray_origin(mouse_pos)
			var to := from + camera.project_ray_normal(mouse_pos) * 1000
			var hit = Plane(Vector3.UP, 1).intersects_ray(from, to)
			if hit:
				global_position = hit
		elif Input.is_action_just_released("ui_click"):
			print("Dropping planet")
			is_being_dragged = false
			GameManager.stop_dragging()
			_return_to_place()
	else:
		if Input.is_action_pressed("ui_click") and on_planet and not GameManager.is_dragging:
				# Start dragging planet
				print("Draggin planet", self)
				is_being_dragged = true
				GameManager.start_dragging(self)
				original_position = global_position
		elif Input.is_action_just_released("ui_click") and on_planet and GameManager.is_dragging:
			if GameManager.object_being_dragged is Crop:
				# Set the crop on click
				crop = GameManager.object_being_dragged
				GameManager.stop_dragging()
				GameManager.next_turn()
				


func _on_mouse_entered() -> void:
	on_planet = true
	GameManager.is_hovering_planet = true
	GameManager.planet_being_hovered = self
	set_glow(true)


func _on_mouse_exited() -> void:
	GameManager.is_hovering_planet = false
	GameManager.planet_being_hovered = null
	on_planet = false
	set_glow(false)


func set_glow(enabled: bool) -> void:
	material.emission_enabled = enabled


func _return_to_place() -> void:
	create_tween().tween_property(self, "global_position", original_position, 0.3).set_trans(Tween.TRANS_SPRING)


func reset_stats() -> void:
	current_crop_growth_multiplier = base_crop_growth_multiplier
	current_score_per_step = base_score_per_step
	current_water_content = base_water_content


func draft(o: OrbitNode) -> void:
	camera = get_viewport().get_camera_3d()
	orbit = o
	GameManager.draft_planet(GameManager.object_being_dragged.planet, o)


func clone() -> PlanetNode:
	var instance := PLANET_SCENE.instantiate() as PlanetNode
	
	instance.name = name
	
	instance.planet_color = planet_color
	instance.planet_size_multiplier = planet_size_multiplier

	instance.base_types = base_types
	instance.current_types = instance.base_types.duplicate(true)

	instance.base_effects = base_effects
	instance.current_effects = instance.base_effects.duplicate(true)

	instance.base_effects_range = base_effects_range
	instance.current_effects_range = instance.base_effects_range

	instance.base_water_content = base_water_content
	instance.current_water_content = instance.base_water_content
	
	instance.base_crop_growth_multiplier = base_crop_growth_multiplier
	instance.current_crop_growth_multiplier = instance.base_crop_growth_multiplier
	
	instance.base_score_per_step = base_score_per_step
	instance.current_score_per_step = instance.base_score_per_step
	
	return instance


static func generate_new() -> PlanetNode:
	var instance := PLANET_SCENE.instantiate() as PlanetNode
	instance.name = str(randi())

	instance.base_types = [PlanetType.values().pick_random()]
	instance.current_types = instance.base_types.duplicate()

	instance.base_effects = [HydratingPlanetEffect.new()]
	instance.current_effects = instance.base_effects.duplicate()

	instance.base_effects_range = randi_range(1, 6)
	instance.current_effects_range = instance.base_effects_range

	instance.base_water_content = WaterContent.values().pick_random()
	instance.current_water_content = instance.base_water_content
	
	instance.base_crop_growth_multiplier = snappedf(randf_range(0.8, 1.2), 0.1)
	instance.current_crop_growth_multiplier = instance.base_crop_growth_multiplier
	
	instance.base_score_per_step = randi_range(75, 150)
	instance.current_score_per_step = instance.base_score_per_step

	return instance
