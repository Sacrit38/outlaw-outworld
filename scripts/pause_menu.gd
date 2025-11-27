extends Control
@onready var volume: HSlider = $PausedMenu/VBoxContainer/volume
const MIN_DB := -50.0  # silence floor
const MAX_DB := 0.0   # normal volume

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

func escape():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(0, 0.0)
	volume.value = 0.50
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
	Global.game_running = false
	hide()

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_option_pressed() -> void:
	print("option pressed")
	paused_menu.visible = false
	option_menu.visible = true

func _on_back_option_pressed() -> void:
	_ready()

func _on_volume_value_changed(value) -> void:
	# slider gives 0.0 – 1.0
	var db = lerp(MIN_DB, MAX_DB, value)
	AudioServer.set_bus_volume_db(0, db)
