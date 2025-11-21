extends Node2D

const outlaw_start := Vector2i(100, 510)
const camera_start := Vector2i(576, 321)
const speed :float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func new_game():
	$Outlaw.position = outlaw_start
	$Camera2D.position = camera_start
	$Ground.position = Vector2i(572,596)
	$Ground2.position = Vector2i(1724,596)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Outlaw.position.x += speed*delta
	$Camera2D.position.x += speed*delta
	$Outlaw.actions()
	
	if $Camera2D.position.x - $Ground.position.x > Global.screen_size.x:
		$Ground.position.x += 1152*2
	elif $Camera2D.position.x - $Ground2.position.x > Global.screen_size.x:
		$Ground2.position.x += 1152*2
