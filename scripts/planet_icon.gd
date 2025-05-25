extends Control

@export var text:String = "x0"
@onready var label: Label = $Label

func _ready() -> void:
	label.text = text
