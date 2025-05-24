class_name HydratingPlanetEffect
extends BasePlanetEffect

# To illustrate how we can do proximity bonuses. 

func on_step(parent_planet: PlanetData, planet_list: PlanetList) -> void:
	var nearby: = PlanetManager.get_nearby_planets(parent_planet)
	for planet in planet_list.planets:
		if planet in nearby:
			planet.current_water_content = planet.current_water_content + 1 as PlanetData.WaterContent
		else:
			planet.current_water_content = max(
				planet.current_water_content - 1 as PlanetData.WaterContent,
				planet.base_water_content
			)
