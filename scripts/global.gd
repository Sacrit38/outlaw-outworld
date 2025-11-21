extends Node

var screen_size: Vector2i

func _ready() -> void:
	screen_size = get_window().size
	get_window().connect("size_changed", _on_size_changed)
	
	
func _on_size_changed():
	screen_size = get_window().size
