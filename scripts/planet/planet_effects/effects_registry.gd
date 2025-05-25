class_name EffectsRegistry
extends Node

static var effects = {
	"hydrated": HydratingPlanetEffect,
	"plutonic": PlutonicPlanetEffect
}

static func get_random_effect() -> BasePlanetEffect:
	return effects.values().pick_random().new()
