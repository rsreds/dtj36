class_name BasePlanetEffect
extends RefCounted

var name: String
var description: String

signal on_drafted_done
signal on_step_done
signal on_orbit_done
signal on_trigger_done

## on_drafted()
##
## When a planet is added to the PlanetList, this func fires.
## `parent_planet` is the planet with this effect.
## The `planet_list` PlanetList can be used for adjaceny effects etc.
func on_drafted(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	on_drafted_done.emit()


## on_step()
##
## When a planet completes a step, this func fires.
## `parent_planet` is the planet with this effect.
## The `planet_list` PlanetList can be used for adjaceny effects etc.
func on_step(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	on_step_done.emit()


## on_orbit()
##
## When a planet completes an orbit, this func fires.
## `parent_planet` is the planet with this effect.
## The `planet_list` PlanetList can be used for adjaceny effects etc.
func on_orbit(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	on_orbit_done.emit()


## on_trigger()
##
## When a planet is given some arbitrary effect trigger, this func fires.
## `parent_planet` is the planet with this effect.
## The `planet_list` PlanetList can be used for adjaceny effects etc.
func on_trigger(parent_planet: PlanetNode, planet_list: Array[PlanetNode]) -> void:
	on_trigger_done.emit()
