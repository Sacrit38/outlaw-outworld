extends Node2D

const SPEED = 100
var state : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	$AnimatedSprite2D.play()
	var visible_rect_size = get_viewport().size
	print("Visible viewport size: " + str(visible_rect_size.x) + "x" + str(visible_rect_size.y))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_running:
		if state == 1:
			$Hitbox.position.y -= SPEED * delta
			pass
		if state == 2:
			$Hitbox.position.y += SPEED * delta
			pass
		if state == 3:
			queue_free()
			pass
		
		pass

func _on_timer_timeout() -> void:
	state+=1
	if state < 3:
		$Timer.start()
		pass
	pass # Replace with function body.
