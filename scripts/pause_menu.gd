extends Control

@onready var paused_menu: PanelContainer = $PausedMenu
@onready var option_menu: PanelContainer = $OptionMenu

func resume():
	get_tree().paused = false
	$"../AnimationPlayer".play_backwards("blur")
	hide()

func pause():
	show()
	get_tree().paused = true
	$"../AnimationPlayer".play_backwards("blur")
	
	paused_menu.visible = true
	option_menu.visible = false

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
	if Global.boss_phase:
		Global.boss_defeated()
	Global.check_high_score()
	Global.game_running = false
	Global.chapter = 1
	Global.boss_phase = false

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_option_pressed() -> void:
	print("option pressed")
	paused_menu.visible = false
	option_menu.visible = true

func _on_back_option_pressed() -> void:
	_ready()

func _on_volume_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(0, value)

func _on_mute_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
