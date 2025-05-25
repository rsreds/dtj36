class_name BountifulPlanetEffect
extends BasePlanetEffect

# To illustrate how we can do proximity bonuses. 

func _init() -> void:
	name = "Bountiful"
	description = "+500 points on draft"

func on_drafted(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	GameManager.score += 500
