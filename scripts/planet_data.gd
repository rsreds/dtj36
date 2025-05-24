class_name PlanetData
extends Resource

enum PlanetType {
	RED,
	YELLOW,
	BLUE,
	GREEN,
	WHITE
}

enum WaterContent {
	LOW,
	MEDIUM,
	HIGH
}

# Features a base and a current value for every member, since certain effects
# might change those members on a temporary basis (proximity, orbit rank, etc.)
# Ultimately, we shouldn't assume a change to a value is permanent.

var name: String

var base_types: Array[PlanetType]
var current_types: Array[PlanetType]

var base_effects: Array[BasePlanetEffect]
var current_effects: Array[BasePlanetEffect]
var base_effects_range: int
var current_effects_range: int
	
var base_water_content: WaterContent
var current_water_content: WaterContent

var base_score_per_step: int
var current_score_per_step: int
