extends Node2D

const outlaw_start := Vector2i(100, 510)
const camera_start := Vector2i(576, 321)
const speed :float = 500.0
var screen_size : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	new_game()

func new_game():
	$Outlaw.position = outlaw_start
	$Camera2D.position = camera_start
	$Ground.position = Vector2i(576,620)
	$Ground2.position = Vector2i(1728,620)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Outlaw.position.x += speed*delta
	$Camera2D.position.x += speed*delta
	$Outlaw.actions()
	
	if $Camera2D.position.x - $Ground.position.x > screen_size.x:
		$Ground.position.x += 1152*2
	elif $Camera2D.position.x - $Ground2.position.x > screen_size.x:
		$Ground2.position.x += 1152*2
	#if $Ground.position.x <= -576:
		#$Ground.position.x += 1728
	#elif $Ground2.position.x <= -576:
		#$Ground2.position += 1728
