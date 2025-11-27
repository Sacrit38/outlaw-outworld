extends Node2D

var chapter = 1

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	$"Sprite2D-2".position.x += 1152

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if chapter != Global.chapter and Global.chapter == 2:
		chapter = 2
		$"Sprite2D-1".texture = load("res://assets/parallax background/s2/1.png")
		$"Sprite2D-2".texture = load("res://assets/parallax background/s2/1.png")
	if Global.game_running:
		if $"../Camera2D".position.x - $"Sprite2D-1".position.x > Global.screen_size.x*1.5:
			$"Sprite2D-1".position.x += 1152*2
		elif $"../Camera2D".position.x - $"Sprite2D-2".position.x > Global.screen_size.x*1.5:
			$"Sprite2D-2".position.x += 1152*2
