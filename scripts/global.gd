extends Node

var screen_size: Vector2i
var game_running: bool = false
var high_score: int = 0
const SCORE_MODIFIER: int = 10
var score: int

func check_high_score():
	if score/SCORE_MODIFIER > high_score:
		high_score = score/SCORE_MODIFIER

func _ready() -> void:
	screen_size = get_window().size
	get_window().connect("size_changed", _on_size_changed)
	
	
func _on_size_changed():
	screen_size = get_window().size
