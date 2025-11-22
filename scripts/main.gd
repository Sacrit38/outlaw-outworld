extends Node2D

var flying_heights := [200, 390]
const OUTLAW_START := Vector2i(200, 510)
const CAMERA_START := Vector2i(576, 321)
const SPEED :float = 500.0
const SCORE_MODIFIER: int = 10
var score: int
var high_score: int

func show_score():
	@warning_ignore("integer_division")
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score/ SCORE_MODIFIER)

func show_high_score():
	$HUD.get_node("HighScore").text = "HIGH SCORE: " + str(high_score)

func check_high_score():
	if score > high_score:
		high_score = score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	high_score = score
	new_game()

func new_game():
	$Outlaw.position = OUTLAW_START
	$Camera2D.position = CAMERA_START
	$Ground.position = Vector2i(572,596)
	$Ground2.position = Vector2i(1724,596)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Outlaw.position.x += SPEED*delta
	$Camera2D.position.x += SPEED*delta
	$Outlaw.actions()
	
	if $Camera2D.position.x - $Ground.position.x > Global.screen_size.x:
		$Ground.position.x += 1152*2
	elif $Camera2D.position.x - $Ground2.position.x > Global.screen_size.x:
		$Ground2.position.x += 1152*2
	
	show_score()
	show_high_score()

func _physics_process(delta: float) -> void:
	#Update Score
	@warning_ignore("narrowing_conversion")
	score += SPEED * delta
