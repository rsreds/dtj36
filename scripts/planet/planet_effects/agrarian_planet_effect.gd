class_name AgrarianPlanetEffect
extends BasePlanetEffect

# To illustrate how we can do proximity bonuses. 

func _init() -> void:
	name = "Agrarian"
	description = "+0.1x crop yield multiplier for each orbit"

func on_orbit(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	parent_planet.base_crop_growth_multiplier += 0.1
	await GameManager.show_point_popup("+%s" % 0.1, parent_planet, Color.SEA_GREEN)
