extends Node2D

const outlaw_start := Vector2i(48, 510)
const camera_start := Vector2i(576, 321)

const speed :float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func new_game():
	$Outlaw.position = outlaw_start
	$Camera2D.position = camera_start
	$Ground.position = Vector2i(576,620)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Outlaw.position.x += speed * delta
	$Camera2D.position.x += speed * delta
