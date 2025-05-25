## GameManager.gd
##
## Controls objectives and resource values, plus calls on delegate managers to perform actions
extends Node

signal win
signal lose
signal step

const SCORE_POPUP = preload("res://scenes/score_popup.tscn")
var muted: bool = false

var score: int = 0:
	set(value):
		score = value
		get_tree().root.get_node("Container/SidePanel/HBoxCropContainer/Panel/VBoxContainer/Label2").text = str(value)

var total_steps: int = 50
var current_steps:int = 0

var level: int = 0

var is_dragging: bool = false
var is_hovering_planet: bool = false
var object_being_dragged: Variant = null
var planet_being_hovered: PlanetNode = null

var orbits: Array[OrbitNode] = []
var planets: Array[PlanetNode] = []

var crop_list: Array[Dictionary] = [
	{"name": "Crimson Strands", "optimal_water":0, "base_growth_rate":1, "amount":0},
	{"name": "Snowsponge", "optimal_water":2, "base_growth_rate":2, "amount":0},
	{"name": "Star Mangoes", "optimal_water":1, "base_growth_rate":1, "amount":0},
	{"name": "Soylent Greens", "optimal_water":0, "base_growth_rate":1, "amount":0},
	{"name": "Sprinks", "optimal_water":0, "base_growth_rate":1, "amount":0}
]

var level_list = [
	[
		Objective.new("Earn 1000 credits", func (): return score >= 1000)
	],
	[
		Objective.new("Earn 2000 credits", func (): return score >= 2000), 
		Objective.new("Harvest 20 Crimson Strands", func (): return crop_list[0]['amount'] >= 20)
	],
	[
		Objective.new("Earn 3000 credits", func (): return score >= 3000), 
		Objective.new("Have 4 planets", func (): return len(planets) >= 4),
		Objective.new("Harvest 10 of each plant", func (): return crop_list[0]['amount'] >= 10 and crop_list[3]['amount'] >= 10 and crop_list[1]['amount'] >= 10),
	],
	[
		Objective.new("Earn 4000 credits", func (): return score >= 3000), 
		Objective.new("Have 6 planets", func (): return len(planets) >= 4),
		Objective.new("Harvest 20 of each plant", func (): return crop_list[0]['amount'] >= 20 and crop_list[3]['amount'] >= 20 and crop_list[1]['amount'] >= 20 and crop_list[4]['amount'] >= 20 and crop_list[2]['amount'] >= 20),
	],
]


func _ready() -> void:
	pass


func check_objectives() -> bool:
	return level_list[level].all(func (o): return o.function.call())

func show_point_popup(text:String, planet: PlanetNode, text_color:Color = Color.WHITE):
	var camera = get_viewport().get_camera_3d()
	var point = SCORE_POPUP.instantiate()
	point.text = text
	point.text_color = text_color
	point.position = camera.unproject_position(planet.global_position)
	get_tree().root.add_child(point)
	await point.done


func next_turn() -> void:
	for o in orbits:
		o.step()
		if o.planet:
			o.planet.reset_stats()
			for effect in o.planet.current_effects:
				effect.on_step(o.planet, planets)
				if o.orbit_completed:
					effect.on_orbit(o.planet, planets)
			var mult = (1 + (0.1 * o.orbit_distance))
			GameManager.show_point_popup("%s*%s" % [o.planet.current_score_per_step, mult], o.planet, Color.GOLDENROD)
			o.planet.accumulated_score += o.planet.current_score_per_step * mult
			if o.orbit_completed:
				score += o.planet.accumulated_score
				o.planet.accumulated_score = 0
				o.orbit_completed = false
	current_steps += 1
	step.emit()
	if current_steps == total_steps:
		if check_objectives():
			win.emit()
		else:
			lose.emit()
	
	
func draft_planet(new_planet_data: PlanetNode, orbit: OrbitNode) -> void:
	planets.assign(orbits.map(func (o): return o.planet).filter(func (p): return p != null))
	for effect in new_planet_data.current_effects:
		effect.on_drafted(new_planet_data, planets)
	next_turn()


func get_nearby_planets(planet: PlanetNode) -> Array[PlanetNode]:
	var p: Array[PlanetNode]
	p.assign(planets.filter(func (x): return x != null).filter(
		func (p: PlanetNode): 
			return planet != p and planet.global_position.distance_to(p.global_position) <= planet.current_effects_range  
	))
	return p


func start_dragging(information: Variant) -> void:
	is_dragging = true
	object_being_dragged = information


func stop_dragging():
	is_dragging = false
	object_being_dragged = null

func reset():
	current_steps = 0
	
