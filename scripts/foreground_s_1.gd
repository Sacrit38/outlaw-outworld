extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Sprite2D-2".position.x += 1152


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"../Camera2D".position.x - $"Sprite2D-1".position.x > Global.screen_size.x*1.5:
		$"Sprite2D-1".position.x += 1152*2
	elif $"../Camera2D".position.x - $"Sprite2D-2".position.x > Global.screen_size.x*1.5:
		$"Sprite2D-2".position.x += 1152*2
