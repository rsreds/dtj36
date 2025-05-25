extends HBoxContainer

var hidden_position: Vector2 = Vector2.ZERO
@onready var harvest_panel: Panel = $HarvestPanel
var panel_hidden: bool = false

func anim_show() -> void:
	panel_hidden = false
	var tween:Tween = create_tween()
	tween.tween_property(self,
	"custom_minimum_size:y",
	100,
	0.3).set_ease(Tween.EASE_IN_OUT)
	

func anim_hide() -> void:
	if harvest_panel.harvesting:
		await harvest_panel.done_harvesting
	var tween:Tween = create_tween()
	tween.tween_property(self,
	"custom_minimum_size:y",
	0,
	0.3).set_ease(Tween.EASE_IN_OUT)
	panel_hidden = true


func _process(delta: float) -> void:
	if GameManager.is_dragging and GameManager.object_being_dragged is PlanetNode and panel_hidden:
		anim_show()
	if not GameManager.is_dragging and not panel_hidden:
		anim_hide()
