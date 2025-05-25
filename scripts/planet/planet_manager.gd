## PlanetManager
##
## Manages the PlanetList and mappings to Nodes.
extends Node

var planet_list: PlanetList = PlanetList.new()

func get_nearby_planets(planet: PlanetNode) -> Array[PlanetNode]:
	var nearby: Array[PlanetNode] = []

	for other in planet_list.planets.values():
		if other == planet:
			continue
		if planet.global_position.distance_to(other.global_position) <= planet.current_effects_range:
			nearby.append(other)

	return nearby
