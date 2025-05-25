extends Node

var planet_deck: Array[PlanetNode]

func _ready() -> void:
	planet_deck.resize(30)
	for i in range(30):
		var planet = PlanetNode.generate_new()
		planet.planet_color = Color(randf(), randf(), randf())
		planet.planet_size_multiplier = randf_range(1, 7.5)
		planet_deck[i] = planet

func pop_top_planet() -> PlanetNode:
	return planet_deck.pop_back()
