extends HBoxContainer

var hidden_position: Vector2
@onready var harvest_panel: Panel = $HarvestPanel

func _ready() -> void:
	hidden_position = position

func anim_show() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(self,
	"position:y",
	hidden_position.y - 100,
	0.3).set_ease(Tween.EASE_IN_OUT)

func anim_hide() -> void:
	if harvest_panel.harvesting:
		await harvest_panel.done_harvesting
	var tween:Tween = create_tween()
	tween.tween_property(self,
	"position:y",
	hidden_position.y,
	0.3).set_ease(Tween.EASE_IN_OUT)


func _process(delta: float) -> void:
	if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode:
		anim_show()
	if not GameManager.is_dragging:
		anim_hide()
