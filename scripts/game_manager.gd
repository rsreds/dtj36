## GameManager.gd
##
## Controls objectives and resource values, plus calls on delegate managers to perform actions
extends Node

var score: int

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
	pass
