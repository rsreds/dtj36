extends Control

@export var text: String = "+1"

func _ready() -> void:
	$Label.text = text
	$AnimationPlayer.play("pop_up")
