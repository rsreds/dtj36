extends Control
@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
@onready var texture_rect: TextureRect = $TextureRect
const SPACE_TOOLTIP = preload("res://scenes/space_tooltip.tscn")
@onready var tooltip_view: PanelContainer = $TooltipView

func _process(delta: float) -> void:
	if not GameManager.is_dragging:
		if not GameManager.is_hovering_planet:
			visible = false
			tooltip_view.visible = false
			texture_rect.visible = false
			sub_viewport_container.visible = false
		else:
			visible = true
			tooltip_view.visible = true
		
	if Input.is_action_just_pressed("ui_click"):
		if GameManager.object_being_dragged is PlanetCard:
			var new_planet:PlanetNode = GameManager.object_being_dragged.planet.duplicate()
			new_planet.position = Vector3.ZERO
			sub_viewport_container.free()
			sub_viewport_container = SPACE_TOOLTIP.instantiate()
			sub_viewport_container.get_child(0).add_child(new_planet)
			sub_viewport_container.visible = true
			sub_viewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
			add_child(sub_viewport_container)
			print(sub_viewport_container.get_children())
			texture_rect.visible = false
			tooltip_view.visible = false
			visible = true
		if GameManager.object_being_dragged is Crop:
			sub_viewport_container.visible = false
			texture_rect.visible = true
			tooltip_view.visible = false
			visible = true
	else:
		var mouse_position = get_global_mouse_position()
		position = mouse_position
