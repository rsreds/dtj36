extends HBoxContainer

var shown_position:Vector2 = Vector2(0,548)
var hidden_position:Vector2 = Vector2(0,648)
@onready var harvest_panel: Panel = $HarvestPanel

func anim_show() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(self,
	"position",
	shown_position,
	0.3).set_ease(Tween.EASE_IN_OUT)

func anim_hide() -> void:
	if harvest_panel.harvesting:
		await harvest_panel.done_harvesting
	var tween:Tween = create_tween()
	tween.tween_property(self,
	"position",
	hidden_position,
	0.3).set_ease(Tween.EASE_IN_OUT)


func _process(delta: float) -> void:
	if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode:
		anim_show()
	if not GameManager.is_dragging:
		anim_hide()
