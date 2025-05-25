class_name Objective
extends Resource

var description: String
var function: Callable

func _init(desc: String, fn: Callable) -> void:
	description = desc
	function = fn
