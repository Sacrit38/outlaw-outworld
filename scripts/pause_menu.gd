extends Control

func resume():
	get_tree().paused = false
	$"../AnimationPlayer".play_backwards("blur")
	hide()

func pause():
	show()
	get_tree().paused = true
	$"../AnimationPlayer".play_backwards("blur")

func escape():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../AnimationPlayer".play_backwards("blur")
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	escape()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	Global.check_high_score()
	get_tree().reload_current_scene()
	var player = get_node("../../Outlaw")
	if player.state != player.STATE_RUN:
		player.state = player.STATE_RUN
	Global.game_running = false


func _on_quit_pressed() -> void:
	get_tree().quit()
