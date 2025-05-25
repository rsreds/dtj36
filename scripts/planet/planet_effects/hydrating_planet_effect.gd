class_name HydratingPlanetEffect
extends BasePlanetEffect

# To illustrate how we can do proximity bonuses. 

func _init() -> void:
	name = "Hydrating"
	description = "Increases water content of planets in range"

func on_step(parent_planet: PlanetNode, planet_list: PlanetList) -> void:
	var nearby: = PlanetManager.get_nearby_planets(parent_planet)
	for planet in planet_list.planets.values():
		if planet in nearby:
			planet.current_water_content = planet.current_water_content + 1 as PlanetNode.WaterContent
		else:
			planet.current_water_content = max(
				planet.current_water_content - 1 as PlanetNode.WaterContent,
				planet.base_water_content
			)
