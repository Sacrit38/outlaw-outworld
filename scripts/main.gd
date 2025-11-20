extends Node2D

const outlaw_start := Vector2i(100, 510)
const camera_start := Vector2i(576, 321)

const speed :float = 500.0

var viewportX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func new_game():
	viewportX = get_viewport().size.x
	$Outlaw.position = outlaw_start
	$Camera2D.position = camera_start
	$Ground.position = Vector2i(viewportX/2,620)
	$Ground2.position = Vector2i((viewportX/2)*3,620)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Ground.position.x += -speed * delta
	$Ground2.position.x += -speed * delta
	$Outlaw.actions()
	
	if $Ground.position.x <= -viewportX/2:
		$Ground.position.x = (viewportX/2)*3
	elif $Ground2.position.x <= -viewportX/2:
		$Ground2.position.x = (viewportX/2)*3
