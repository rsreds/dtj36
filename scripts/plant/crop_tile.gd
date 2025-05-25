extends PanelContainer

@export var crop_info: Crop
@onready var texture: AtlasTexture = $TextureRect.texture
@onready var label: Label = $TextureRect/Label

var this_is_dragging:bool = false

func _ready() -> void:
	if crop_info.name == GameManager.crop_list[0]["name"]:
		texture.region = Rect2(199.25, 31.5, 122, 154)
	elif crop_info.name == GameManager.crop_list[1]["name"]:
		texture.region = Rect2(345.25, -2, 117, 182)
	elif crop_info.name == GameManager.crop_list[2]["name"]:
		texture.region = Rect2(0, 0, 150, 155)
	elif crop_info.name == GameManager.crop_list[3]["name"]:
		texture.region = Rect2(14.563, 201, 141, 150)
	elif crop_info.name == GameManager.crop_list[4]["name"]:
		texture.region = Rect2(174.5, 232, 164, 142)
	tooltip_text = crop_info.name

func _gui_input(event):
	if event.is_action_pressed("ui_click") and not GameManager.is_dragging:
		GameManager.is_dragging = true
		this_is_dragging = true
		GameManager.start_dragging(crop_info)
		print("Picked up ", crop_info.name)


func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_click"):
		if GameManager.is_dragging and this_is_dragging:
			GameManager.stop_dragging()
			this_is_dragging = false
			print("Dropped ", crop_info.name)
	if Input.is_action_just_released("ui_click"):
		pivot_offset = Vector2(size.x/2, size.y)
		scale = Vector2(1,1)
	var amount
	var objective
	for crop in GameManager.crop_list:
		if crop_info.name == crop['name']:
			amount = crop['amount']
	label.text = "x%d" % [amount]

func _on_mouse_entered() -> void:
	if not GameManager.is_dragging:
		pivot_offset = Vector2(size.x/2, size.y)
		scale = Vector2(1.05,1.1)

func _on_mouse_exited() -> void:
	if not GameManager.is_dragging:
		pivot_offset = Vector2(size.x/2, size.y)
		scale = Vector2(1,1)
