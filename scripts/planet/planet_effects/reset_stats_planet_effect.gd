extends BasePlanetEffect

func on_orbit(parent_planet: PlanetNode, planet_list: PlanetList) -> void:
	parent_planet.current_crop_growth_multiplier = parent_planet.base_crop_growth_multiplier ## TODO: this will break some stuff at some point
