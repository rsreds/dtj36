class_name PlanetList
extends Resource

var planets: Dictionary[OrbitNode, PlanetNode]


func step_all():
	print(planets)
	for planet in planets.values():
		planet.reset_stats()
		for effect in planet.current_effects:
			effect.on_step(planet, self)


func orbit_all():
	for planet in planets.values():
		for effect in planet.current_effects:
			effect.on_orbit(planet, self)


func trigger_all():
	for planet in planets.values():
		for effect in planet.current_effects:
			effect.on_trigger(planet, self)
