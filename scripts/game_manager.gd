## GameManager.gd
##
## Controls objectives and resource values, plus calls on delegate managers to perform actions
extends Node

enum ActivateTool {
	DESTROY,
	BLUE_PLANT,
	RED_PLANT,
	YELLOW_PLANT,
	GREEN_PLANT,
	WHITE_PLANT,
	FERTILISER
}

var score: int

var corporation_check_count: int = 0

var green_plants_collected: int
var red_plants_collected: int
var blue_plants_collected: int
var yellow_plants_collected: int
var white_plants_collected: int

var objectives: Array[Callable] = []


func _ready() -> void:
	create_new_objectives()


func next_turn() -> void:
	PlanetManager.next_turn()


func create_new_objectives() -> void:
	var number_of_objectives: int = int(corporation_check_count / 3) + 3
	for i in number_of_objectives:
		pass
