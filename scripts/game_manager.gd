## GameManager.gd
##
## Controls objectives and resource values, plus calls on delegate managers to perform actions
extends Node

var muted: bool = false

var score: int

var corporation_check_count: int = 0

var green_plants_collected: int
var red_plants_collected: int
var blue_plants_collected: int
var yellow_plants_collected: int
var white_plants_collected: int

var objectives: Array[Callable] = []

var is_dragging: bool = false
var is_hovering_planet: bool = false
var object_being_dragged: Variant = null

var orbits: Array[OrbitNode] = []

var crop_list:Array[Dictionary] = [
	{"name": "Crimson Strands", "optimal_water":0, "base_growth_rate":1},
	{"name": "Snowsponge", "optimal_water":2, "base_growth_rate":2},
	{"name": "Star Mangoes", "optimal_water":1, "base_growth_rate":1},
	{"name": "Soylent Greens", "optimal_water":0, "base_growth_rate":1},
	{"name": "Sprinks", "optimal_water":0, "base_growth_rate":1}
]

func _ready() -> void:
	create_new_objectives()

func next_turn() -> void:
	PlanetManager.next_turn()
	for o in orbits:
		o.step()

func start_dragging(information: Variant) -> void:
	is_dragging = true
	object_being_dragged = information


func stop_dragging():
	is_dragging = false
	object_being_dragged = null

func create_new_objectives() -> void:
	var number_of_objectives: int = int(corporation_check_count / 3) + 3
	for i in number_of_objectives:
		pass
