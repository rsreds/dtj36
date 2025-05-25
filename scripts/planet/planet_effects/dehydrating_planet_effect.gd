class_name DehydratingPlanetEffect
extends BasePlanetEffect

# To illustrate how we can do proximity bonuses. 

func _init() -> void:
	name = "Dehydrating"
	description = "Decreases water content of planets in range"

func on_step(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	var nearby := GameManager.get_nearby_planets(parent_planet)
	for planet in planet_list:
		if planet in nearby:
			planet.current_water_content = planet.current_water_content - 1 as PlanetNode.WaterContent
			GameManager.show_point_popup('-1', planet, Color.PALE_TURQUOISE)
