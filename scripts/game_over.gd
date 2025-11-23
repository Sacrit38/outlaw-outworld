extends Control

func _ready() -> void:
	get_tree().paused = false
	$"../AnimationPlayer".play_backwards("blur")
	hide() 

func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("restart"):
		#_on_restart_pressed()
	#elif Input.is_action_just_pressed("quit"):
		#_on_quit_pressed() 
	pass

func show_game_over():
	get_tree().paused = true
	show()
	$"../AnimationPlayer".play_backwards("blur")

func _on_restart_pressed() -> void:
	health.set_health(5)
	health.set_max_health(5)
	get_tree().paused = false
	$"../AnimationPlayer".play_backwards("blur")
	hide()
	Global.check_high_score()
	get_tree().reload_current_scene()
	var player = get_node("../../Outlaw")
	if player.state != player.STATE_RUN:
		player.state = player.STATE_RUN
	Global.game_running = false

func _on_quit_pressed() -> void:
	get_tree().quit() 
