extends Node2D

@onready var collision : CollisionShape2D = $HitBox/HitboxShape
const SPEED = 100
var state : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	collision.scale.x = 1
	var visible_rect_size = get_viewport().size
	print("Visible viewport size: " + str(visible_rect_size.x) + "x" + str(visible_rect_size.y))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_running:
		if state == 2:
			collision.scale.x = get_viewport().size.x
			pass
		if state == 3:
			queue_free()
			pass
		
		pass

func _on_timer_timeout() -> void:
	state+=1
	pass # Replace with function body.
