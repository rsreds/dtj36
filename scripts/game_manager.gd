## GameManager.gd
##
## Controls objectives and resource values, plus calls on delegate managers to perform actions
extends Node

const SCORE_POPUP = preload("res://scenes/score_popup.tscn")
var muted: bool = false

var score: int

var level: int = 0

var green_plants_collected: int
var red_plants_collected: int
var blue_plants_collected: int
var yellow_plants_collected: int
var white_plants_collected: int

var objectives: Array[Callable] = []

var is_dragging: bool = false
var is_hovering_planet: bool = false
var object_being_dragged: Variant = null
var planet_being_hovered: PlanetNode = null

var orbits: Array[OrbitNode] = []
var planets: Array[PlanetNode] = []

var crop_list:Array[Dictionary] = [
	{"name": "Crimson Strands", "optimal_water":0, "base_growth_rate":1, "amount":0, "objective":15},
	{"name": "Snowsponge", "optimal_water":2, "base_growth_rate":2, "amount":0, "objective":20},
	{"name": "Star Mangoes", "optimal_water":1, "base_growth_rate":1, "amount":0, "objective":25},
	{"name": "Soylent Greens", "optimal_water":0, "base_growth_rate":1, "amount":0, "objective":10},
	{"name": "Sprinks", "optimal_water":0, "base_growth_rate":1, "amount":0, "objective":5}
]

var level_list = [
	[
		Objective.new("Earn 1000 credits", func (): return score >= 1000)
	],
	[
		Objective.new("Earn 2000 credits", func (): return score >= 2000), 
		Objective.new("Harvest 20 Crimson Strands", func (): return red_plants_collected >= 20)
	],
	[
		Objective.new("Earn 3000 credits", func (): return score >= 3000), 
		Objective.new("Have 4 planets", func (): return len(planets) >= 4),
		Objective.new("Harvest 10 of each plant", func (): return red_plants_collected >= 10 and green_plants_collected >= 10 and white_plants_collected >= 10),
	],
	[
		Objective.new("Earn 4000 credits", func (): return score >= 3000), 
		Objective.new("Have 6 planets", func (): return len(planets) >= 4),
		Objective.new("Harvest 20 of each plant", func (): return red_plants_collected >= 20 and green_plants_collected >= 20 and white_plants_collected >= 20 and blue_plants_collected >= 20 and yellow_plants_collected >= 20),
	],
]


func _ready() -> void:
	pass


func check_objectives() -> bool:
	return level_list[level].all(func (o): return o.function.call())

func show_point_popup(text:String, planet: PlanetNode):
	var camera = get_viewport().get_camera_3d()
	var point = SCORE_POPUP.instantiate()
	point.text = text
	point.position = camera.unproject_position(planet.global_position)
	get_tree().root.add_child(point)


func next_turn() -> void:
	for o in orbits:
		o.step()
		if o.planet:
			o.planet.reset_stats()
			for effect in o.planet.current_effects:
				effect.on_step(o.planet, planets)


func draft_planet(new_planet_data: PlanetNode, orbit: OrbitNode) -> void:
	planets.assign(orbits.map(func (o): return o.planet).filter(func (p): return p != null))
	for effect in new_planet_data.current_effects:
		effect.on_drafted(new_planet_data, planets)
	next_turn()


func get_nearby_planets(planet: PlanetNode) -> Array[PlanetNode]:
	var p: Array[PlanetNode]
	p.assign(planets.filter(
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
