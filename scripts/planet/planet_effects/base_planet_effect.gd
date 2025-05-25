class_name BasePlanetEffect
extends RefCounted

var name: String
var description: String

## on_drafted()
##
## When a planet is added to the PlanetList, this func fires.
## `parent_planet` is the planet with this effect.
## The `planet_list` PlanetList can be used for adjaceny effects etc.
func on_drafted(parent_planet: PlanetNode, planet_list: PlanetList) -> void:
	pass


## on_step()
##
## When a planet completes a step, this func fires.
## `parent_planet` is the planet with this effect.
## The `planet_list` PlanetList can be used for adjaceny effects etc.
func on_step(parent_planet: PlanetNode, planet_list: PlanetList) -> void:
	pass


## on_orbit()
##
## When a planet completes an orbit, this func fires.
## `parent_planet` is the planet with this effect.
## The `planet_list` PlanetList can be used for adjaceny effects etc.
func on_orbit(parent_planet: PlanetNode, planet_list: PlanetList) -> void:
	pass


## on_trigger()
##
## When a planet is given some arbitrary effect trigger, this func fires.
## `parent_planet` is the planet with this effect.
## The `planet_list` PlanetList can be used for adjaceny effects etc.
func on_trigger(parent_planet: PlanetNode, planet_list: PlanetList) -> void:
	pass
