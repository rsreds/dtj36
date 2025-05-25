class_name PlanetList
extends Resource

var planets: Array[PlanetNode]


func step_all():
	for planet in planets:
		for effect in planet.current_effects:
			effect.on_step(planet, self)


func orbit_all():
	for planet in planets:
		for effect in planet.current_effects:
			effect.on_orbit(planet, self)


func trigger_all():
	for planet in planets:
		for effect in planet.current_effects:
			effect.on_trigger(planet, self)


func draft_planet(planet: PlanetNode):
	planets.append(planet)
	for effect in planet.current_effects:
		effect.on_drafted(planet, self)
