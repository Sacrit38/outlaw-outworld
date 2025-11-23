extends "res://scripts/melee_enemy.gd"
class_name boss_rangeAttack

@onready var ray_up: RayCast2D = $DetectUp
@onready var ray_down: RayCast2D = $DetectDown

func movement(delta: float) -> void:
	# Add the gravity.
	if ray_up.is_colliding():
		position.x += 0
		position.y += -speed * delta
	elif ray_down.is_colliding():
		position.x += 0
		position.y += speed * delta
	else:
		position.x += speed * delta
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Outlaw":
		queue_free()
	pass # Replace with function body.
