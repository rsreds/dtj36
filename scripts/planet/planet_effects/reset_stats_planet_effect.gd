extends BasePlanetEffect

var is_active: bool = false

func on_trigger(parent_planet: PlanetNode, planet_list: PlanetList) -> void:
	

func on_step(parent_planet: PlanetNode, planet_list: PlanetList) -> void:
	parent_planet.current_crop_growth_multiplier = parent_planet.current_crop_growth_multiplier * 2
