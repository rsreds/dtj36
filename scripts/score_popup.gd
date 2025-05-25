extends Control

@export var text: String = "+1"
signal done

func _ready() -> void:
	$Label.text = text
	$AnimationPlayer.play("pop_up")
	await $AnimationPlayer.animation_finished
	done.emit()
