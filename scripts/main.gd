extends Node2D

var flying_heights := [200, 390]
const OUTLAW_START := Vector2i(200, 510)
const CAMERA_START := Vector2i(576, 321)
const SPEED :float = 500.0
const SCORE_MODIFIER: int = 10
var score: int
var high_score: int

var blood_relic = false
var heart_state = [preload("res://assets/health/dead.png"), preload("res://assets/health/1 heart .png"), preload("res://assets/health/2 hearts.png"), preload("res://assets/health/3 hearts .png"), preload("res://assets/health/4 hearts.png"), preload("res://assets/health/full hearts.png")]
var heart_blood_relic_state = [preload("res://assets/health/dead + blood relic.png"), preload("res://assets/health/1 heart + blood relic.png"), preload("res://assets/health/2 hearts + blood relic.png"), preload("res://assets/health/3 hearts + blood relic.png"), preload("res://assets/health/4 hearts + blood relic.png"), preload("res://assets/health/full hearts, blood relic gone.png"), preload("res://assets/health/full hearts + blood relic .png")]

func show_score():
	@warning_ignore("integer_division")
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score/ SCORE_MODIFIER)

func show_high_score():
	$HUD.get_node("HighScore").text = "HIGH SCORE: " + str(high_score)

func check_high_score():
	if score > high_score:
		high_score = score

# health signal receiver
func _on_health_changed(diff: int):
	print("Health changed by ", diff)

func _on_max_health_changed(diff: int):
	print("Max health changed by ", diff)

func _on_health_depleted():
	print("Player died")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	high_score = score
	new_game()
	
	health.your_global_function()
	
	health.health_changed.connect(_on_health_changed)
	health.max_health_changed.connect(_on_max_health_changed)
	health.health_depleted.connect(_on_health_depleted)
	

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

func health_view():
	var health_ = health.get_health()
	var ins = Sprite2D.new()
	ins.position = Vector2(0, 0)
	
	if blood_relic != false:
		ins.texture = heart_state[health_]
	else:
		ins.texture = heart_blood_relic_state[health_]
	
	add_child(ins)
