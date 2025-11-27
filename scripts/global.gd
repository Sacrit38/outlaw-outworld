extends Node

var screen_size: Vector2i
var game_running: bool = false
var high_score: int = 0
const SCORE_MODIFIER: int = 10
var score: int
var threshold_var: int
var boss_phase: bool
var backward: bool = false
var chapter: int
var threshold = [2000, 30000]
var boss : Node

func check_high_score():
	if score/SCORE_MODIFIER > high_score:
		high_score = score/SCORE_MODIFIER

func _ready() -> void:
	boss_phase = false
	chapter = 1
	screen_size = get_window().size
	get_window().connect("size_changed", _on_size_changed)
	
func _process(_delta: float) -> void:
	if threshold_var > threshold[chapter-1]:
		boss_phase = true
		pass
	pass
	
func boss_defeated():
	threshold_var = 0
	boss.call_deferred("free")
	Player.backward = false
	boss_phase = false
	
func next_chapter():
	boss_phase = false
	threshold_var = 0
	chapter += 1
	#somthin somthin bla bla bla
	
func _on_size_changed():
	screen_size = get_window().size
