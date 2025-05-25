class_name AdvertisingPlanetEffect
extends BasePlanetEffect

# To illustrate how we can do proximity bonuses. 

func _init() -> void:
	name = "Advertising"
	description = "Adjacent planets have +0.2x credits per step"

func on_step(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	var i = planet_list.find(parent_planet)
	if i - 1 >= 0:
		await GameManager.show_point_popup("+%s" % (planet_list[i-1].current_score_per_step * 0.2), planet_list[i-1], Color.GOLDENROD)
		planet_list[i-1].current_score_per_step += planet_list[i-1].current_score_per_step * 0.2
	if i + 1 < len(planet_list):
		await GameManager.show_point_popup("+%s" % (planet_list[i+1].current_score_per_step * 0.2), planet_list[i+1], Color.GOLDENROD)
		planet_list[i+1].current_score_per_step += planet_list[i+1].current_score_per_step * 0.2
