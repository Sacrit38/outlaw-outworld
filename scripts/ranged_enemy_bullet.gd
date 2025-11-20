extends CharacterBody2D
@export var speed = -2000 

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
