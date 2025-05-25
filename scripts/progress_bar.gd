extends ProgressBar
@onready var label: Label = $Label

func _ready() -> void:
	GameManager.connect("step", _on_step)
	var text:String
	for objective in GameManager.level_list[GameManager.level]:
		text = text + " " + objective.description
	label.text = text

func _on_step()->void:
	max_value = GameManager.total_steps
	value = GameManager.current_steps
