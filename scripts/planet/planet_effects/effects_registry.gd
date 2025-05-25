class_name EffectsRegistry
extends Object

static var effects = [
	HydratingPlanetEffect,
	PlutonicPlanetEffect,
	AgrarianPlanetEffect,
	BountifulPlanetEffect,
	DehydratingPlanetEffect,
	AdvertisingPlanetEffect
]

static func get_random_effect() -> BasePlanetEffect:
	return effects.pick_random().new()
