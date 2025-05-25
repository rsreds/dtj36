extends PanelContainer

@export var crop_info: Crop

var dragging: bool = false

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Clicked")
			dragging = true
			GameManager.start_dragging(crop_info)
		else:
			dragging = false
			GameManager.stop_dragging()
