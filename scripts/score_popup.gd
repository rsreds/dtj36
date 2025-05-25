extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var text: String = "+1"
@export var text_color: Color = Color.WHITE
signal done

func _ready() -> void:
	$Label.text = text
	$Label.add_theme_color_override("font_color", text_color)
	animation_player.play("pop_up")
	await animation_player.animation_finished
	done.emit()

func play_sound()->void:
	MasterAudio.play_pickup_sound()
