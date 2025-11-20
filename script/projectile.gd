extends Area2D

@export var speed: float = 600.0
var dir: Vector2 = Vector2.RIGHT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += dir * speed * delta
	
	if position.x >= 1728:
		queue_free() 
