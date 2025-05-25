extends PanelContainer

@export var crop_info: Crop

func _gui_input(event):
	if event.is_action_pressed("ui_click"):
		GameManager.is_dragging = true
		GameManager.start_dragging(crop_info)

func _on_mouse_entered() -> void:
	if not GameManager.is_dragging:
		pivot_offset = Vector2(size.x/2, size.y)
		scale = Vector2(1.05,1.1)

func _on_mouse_exited() -> void:
	if not GameManager.is_dragging:
		pivot_offset = Vector2(size.x/2, size.y)
		scale = Vector2(1,1)
