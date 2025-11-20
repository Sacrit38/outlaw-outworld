extends CanvasLayer

@onready var pausePanel: Panel = $PausePanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pausePanel.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_option_button_up() -> void:
	print("Settings clicked")
	pass # Replace with function body.


func _on_quit_button_up() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _on_back_button_up() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_pause_button_up() -> void:
	pausePanel.visible = true
	get_tree().paused = false
	pass # Replace with function body.


func _on_resume_button_up() -> void:
	pausePanel.visible = false
	get_tree().paused = true
	pass # Replace with function body.
