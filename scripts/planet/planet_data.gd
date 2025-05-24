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

var crop: Crop
var base_crop_growth_multiplier: float
var current_crop_growth_multiplier: float
var crop_amount: int


static func generate_new() -> PlanetData:
	var instance := PlanetData.new()
	
	instance.name = String.num_uint64(randi())
	
	instance.base_types = [randi_range(0, PlanetType.values().size()) as PlanetType]
	instance.current_types = instance.base_types.duplicate()
	
	instance.base_effects = [HydratingPlanetEffect.new()]
	instance.current_effects = instance.base_effects.duplicate()
	instance.base_effects_range = randi_range(10, 100)
	instance.current_effects_range = instance.base_effects_range
	
	instance.base_water_content = randi_range(0, WaterContent.values().size()) as WaterContent
	instance.current_water_content = instance.base_water_content
	
	return instance
