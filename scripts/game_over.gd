extends Control

func _ready() -> void:
	$"../AnimationPlayer".play_backwards("blur")
	hide() 

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		_on_restart_pressed()
	elif Input.is_action_just_pressed("quit"):
		_on_quit_pressed() 

func show_game_over():
	get_tree().paused = true
	show()
	$"../AnimationPlayer".play_backwards("blur")

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit() 
