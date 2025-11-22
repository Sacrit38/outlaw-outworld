extends Node2D

var flying_heights := [200, 390]

const outlaw_start := Vector2i(100, 510)
const camera_start := Vector2i(576, 321)

const speed :float = 500.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func new_game():
	$Outlaw.position = outlaw_start
	$Camera2D.position = camera_start
	$Ground.position = Vector2i(576,620)
	$Ground2.position = Vector2i(1728,620)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$Ground.position.x += -speed * delta
	$Ground2.position.x += -speed * delta
	
	$Outlaw.actions()
	
	if $Ground.position.x <= -576:
		$Ground.position.x = 1728
	elif $Ground2.position.x <= -576:
		$Ground2.position.x = 1728
