class_name PlutonicPlanetEffect
extends BasePlanetEffect

# To illustrate how we can do proximity bonuses. 

func _init() -> void:
	name = "Plutonic"
	description = "Double credits per step if the outermost planet"

func on_step(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	var furthest: PlanetNode
	for planet in planet_list:
		if furthest == null:
			furthest = planet
		if planet.orbit.orbit_distance > furthest.orbit.orbit_distance:
			furthest = planet
	
	if furthest == parent_planet:
		parent_planet.current_score_per_step = parent_planet.current_score_per_step * 2
