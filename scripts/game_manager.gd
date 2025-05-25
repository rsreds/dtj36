## GameManager.gd
##
## Controls objectives and resource values, plus calls on delegate managers to perform actions
extends Node

var score: int

var corporation_check_count: int = 0

var green_plants_collected: int
var red_plants_collected: int
var blue_plants_collected: int
var yellow_plants_collected: int
var white_plants_collected: int

var objectives: Array[Callable] = []

var is_dragging: bool = false
var is_dragging_new_planet: bool = false
var object_being_dragged: Variant = null


func _ready() -> void:
	create_new_objectives()


func next_turn() -> void:
	PlanetManager.next_turn()


func start_dragging(information: Variant) -> void:
	is_dragging = true
	object_being_dragged = information
	print(information)


func stop_dragging():
	if object_being_dragged:
		is_dragging = false
		object_being_dragged = null


func create_new_objectives() -> void:
	var number_of_objectives: int = int(corporation_check_count / 3) + 3
	for i in number_of_objectives:
		pass
