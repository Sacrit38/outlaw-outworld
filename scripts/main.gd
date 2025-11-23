extends Node2D

var flying_heights := [200, 390]
const OUTLAW_START := Vector2i(200, 510)
const CAMERA_START := Vector2i(576, 321)
const SPEED :float = 500.0
@onready var game_over_screen = $GameOver/GameOver

#set true to stop camera and look back
static var stop_cam = false

var blood_relic = false
var heart_state = [preload("res://assets/health/dead.png"), preload("res://assets/health/1 heart .png"), preload("res://assets/health/2 hearts.png"), preload("res://assets/health/3 hearts .png"), preload("res://assets/health/4 hearts.png"), preload("res://assets/health/full hearts.png")]
var heart_blood_relic_state = [preload("res://assets/health/dead + blood relic.png"), preload("res://assets/health/1 heart + blood relic.png"), preload("res://assets/health/2 hearts + blood relic.png"), preload("res://assets/health/3 hearts + blood relic.png"), preload("res://assets/health/4 hearts + blood relic.png"), preload("res://assets/health/full hearts, blood relic gone.png"), preload("res://assets/health/full hearts + blood relic .png")]

func show_score():
	@warning_ignore("integer_division")
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(Global.score/ Global.SCORE_MODIFIER)

func show_high_score():
	$HUD.get_node("HighScore").text = "HIGH SCORE: " + str(Global.high_score)

func _on_health_depleted():
	#add death / game over
	print("Player died")
	
var viewportX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.score = 0
	new_game()
	$Outlaw.connect("game_over", self.game_over)
	
	#health.your_global_function()
	
	health.health_changed.connect(health_view)
	health.max_health_changed.connect(health_view)
	health.health_depleted.connect(_on_health_depleted)
	

func new_game():
	$Outlaw.position = OUTLAW_START
	$Camera2D.position = CAMERA_START
	$Ground.position = Vector2i(572,596)
	$Ground2.position = Vector2i(1724,596)
	viewportX = get_viewport().size.x
	Global.game_running = false

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
		print(Global.game_running)
	else:
		if Input.is_action_just_pressed("jump_button"):
			Global.game_running = true
			$HUD.get_node("StartLabel").hide()
		print(Global.game_running)

func _physics_process(delta: float) -> void:
	#Update Score
	if Global.game_running:
		#Update Score
		@warning_ignore("narrowing_conversion")
		Global.score += SPEED * delta

func health_view(_diff : int):
	var health_ = health.get_health()
	var ins = $HUD.get_node("Health")
	
	if !blood_relic:
		ins.texture = heart_state[health_]
	else:
		ins.texture = heart_blood_relic_state[health_]
	

func game_over():
	game_over_screen.show_game_over()
