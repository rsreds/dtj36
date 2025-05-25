extends Control

func move_to_position_and_free(target_position:Vector2):
	var tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		target_position,
		0.3
	).set_ease(Tween.EASE_OUT)
	await tween.finished
	queue_free()
	
