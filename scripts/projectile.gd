extends Area2D

@export var screen_size: Vector2i
@export var speed: float = 4200.0
var dir: Vector2 = Vector2.RIGHT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += dir * speed * delta
	

func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()
