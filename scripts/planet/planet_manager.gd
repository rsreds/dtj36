## PlanetManager
##
## Manages the PlanetList and mappings to Nodes.
extends Node

var planet_list: PlanetList = PlanetList.new()

func next_turn() -> void:
	planet_list.step_all()


func draft_planet(new_planet_data: PlanetNode) -> void:
	planet_list.draft_planet(new_planet_data)
	print("Drafted %s" % new_planet_data)
	GameManager.next_turn()


func get_nearby_planets(planet: PlanetNode) -> Array[PlanetNode]:
	var nearby: Array[PlanetNode] = []

	for other in planet_list.planets:
		if other == planet:
			continue
		if planet.global_position.distance_to(other.global_position) <= planet.current_effects_range:
			nearby.append(other)

	return nearby
