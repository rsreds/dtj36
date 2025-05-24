## PlanetManager
##
## Manages the PlanetList and mappings to Nodes.
extends Node

var planet_list: PlanetList

var planet_to_node_map: Dictionary[PlanetData, PlanetNode]


func next_turn() -> void:
	planet_list.step_all()


func generate_new_planet() -> Dictionary[PlanetData, PlanetNode]:
	var node := PlanetNode.new()
	var data := PlanetData.generate_new()
	return {data: node}


func draft_planet(new_planet_data: PlanetData) -> void:
	planet_list.draft_planet(new_planet_data)


func get_planet_node_from_data(planet: PlanetData) -> Node:
	return planet_to_node_map[planet]


func get_nearby_planets(planet: PlanetData) -> Array[PlanetData]:
	var origin_node = get_planet_node_from_data(planet)
	var nearby = []

	for other in planet_list.planets:
		if other == planet:
			continue
		var other_node = get_planet_node_from_data(other)
		if origin_node.global_position.distance_to(other_node.global_position) <= planet.current_effects_range:
			nearby.append(other)

	return nearby
