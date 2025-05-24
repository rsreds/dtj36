class_name PlanetList
extends Resource

var planets: Array[PlanetData]


func step_all():
	for planet in planets:
		planet.effect.on_step(planet, self)


func orbit_all():
	for planet in planets:
		planet.effect.on_orbit(planet, self)


func trigger_all():
	for planet in planets:
		planet.effect.on_trigger(planet, self)


func draft_planet(planet: PlanetData):
	planets.append(planet)
	planet.effect.on_drafted(planet, self)
