extends Node2D

var flying_heights := [200, 390]
const OUTLAW_START := Vector2i(200, 510)
const CAMERA_START := Vector2i(576, 321)
const SPEED :float = 500.0

#set true to stop camera and look back
static var stop_cam = false

func show_score():
	@warning_ignore("integer_division")
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(Global.score/ Global.SCORE_MODIFIER)

func show_high_score():
	$HUD.get_node("HighScore").text = "HIGH SCORE: " + str(Global.high_score)


var viewportX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.score = 0
	new_game()

func new_game():
	$Outlaw.position = OUTLAW_START
	$Camera2D.position = CAMERA_START
	$Ground.position = Vector2i(572,596)
	$Ground2.position = Vector2i(1724,596)
	viewportX = get_viewport().size.x

func start_cam() :
	await get_tree().create_timer(1.0).timeout
	stop_cam = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_running:
		$Outlaw.position.x += SPEED*delta
		if stop_cam:
			start_cam()
		else :
			$Camera2D.position.x += SPEED*delta
		$Outlaw.actions()
		
		if $Camera2D.position.x - $Ground.position.x > Global.screen_size.x:
			$Ground.position.x += 1152*2
		elif $Camera2D.position.x - $Ground2.position.x > Global.screen_size.x:
			$Ground2.position.x += 1152*2
		
		show_score()
		show_high_score()
	else:
		if Input.is_action_just_pressed("jump_button"):
			Global.game_running = true
			$HUD.get_node("StartLabel").hide()

func _physics_process(delta: float) -> void:
	if Global.game_running:
		#Update Score
		@warning_ignore("narrowing_conversion")
		Global.score += SPEED * delta
