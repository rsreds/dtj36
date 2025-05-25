extends Control

@export var text: String = "+1"
@export var color: Color = Color.WHITE
signal done

func _ready() -> void:
	$Label.text = text
	$Label.add_theme_color_override("font_outline_color", color)
	$AnimationPlayer.play("pop_up")
	await $AnimationPlayer.animation_finished
	done.emit()
